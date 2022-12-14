#!/bin/bash

debug=0
spade_bin="./bin/spade"
spade_cfg="./cfg/spade.client.Control.config"

cmd_bin_logs_dir_path="/home/vagrant/trace_bin"
spade_log_msg_str_that_signals_the_cdm_log_has_been_processed="File processing successfully succeeded"
dot_output_dir_path="/home/vagrant/trace_dots"


clear_spade_cfg(){
  truncate -s 0 "${spade_cfg}"
}


is_spade_running(){
  "${spade_bin}" status | grep -q "Running"
}


stop_spade(){
  "${spade_bin}" stop
}


kill_spade(){
  "${spade_bin}" kill
}


try_stop_kill_spade(){
  if is_spade_running; then
    stop_spade
  fi
  sleep 5
  if is_spade_running; then
    kill_spade
  fi
}


start_spade(){
  "${spade_bin}" start
}


send_spade_command(){
  local cmd="${1}"
  echo "${cmd}" | "${spade_bin}" control
  if [ "${debug}" -eq 1 ]; then
    echo "list all" | "${spade_bin}" control
  fi
}


add_graphviz_storage(){
  local output_path="${1}"
  local cmd="add storage Graphviz ${output_path}"
  send_spade_command "${cmd}"
}


remove_graphviz_storage(){
  local cmd="remove storage Graphviz"
  send_spade_command "${cmd}"
}


add_cdm_reporter(){
  local input_log="${1}"
  local cmd="add reporter CDM ${input_log}"
  send_spade_command "${cmd}"
}


remove_cdm_reporter(){
  local cmd="remove reporter CDM"
  local current_log=`ls log -Art | tail -n 1`
  while : ; do
    sleep 10
    if grep -q "${spade_log_msg_str_that_signals_the_cdm_log_has_been_processed}" "log/${current_log}"; then
      break
    fi
  done
  send_spade_command "${cmd}"
}


process_cdm_log_to_dot(){
  local cdm_log_path="${1}"
  local dot_path="${2}"
  try_stop_kill_spade
  clear_spade_cfg
  start_spade
  sleep 1
  ls -l log/current.log
  add_graphviz_storage "${dot_path}"
  sleep 1
  add_cdm_reporter "${cdm_log_path}"
  sleep 5
  remove_cdm_reporter
  sleep 5
  remove_graphviz_storage
  sleep 5
  stop_spade
}


assert_check(){
  [ -z "${cmd_bin_logs_dir_path}" ] && echo "Must set the variable 'cmd_bin_logs_dir_path' to the path of the CDM binary logs for TCE3" && exit 1
  [ ! -d "${cmd_bin_logs_dir_path}" ] && echo "The path of the CDM binary logs directory for TCE3 is not a directory" && exit 1
  [ -z "${dot_output_dir_path}" ] && echo "Must set the variable 'dot_output_dir_path'" to the path of the Graphviz output directory" && exit 1
  [ ! -d "${dot_output_dir_path}" ] && echo "The path of the Graphviz output directory is not a directory" && exit 1
  [ -z "${spade_log_msg_str_that_signals_the_cdm_log_has_been_processed}" ] && echo "Must set the variable 'spade_log_msg_str_that_signals_the_cdm_log_has_been_processed'" && exit 1
}


main_loop(){
  assert_check

  local i= name= cdm_log_path= dot_path= line_count= idx=0
  for i in `ls ${cmd_bin_logs_dir_path}`; do
    idx=$((idx+1))
    cdm_log_path="${cmd_bin_logs_dir_path}/${i}"
    dot_path="${dot_output_dir_path}/${idx}.dot"
    if [ ! -f "${cdm_log_path}" ]; then
      echo "Skipped non-regular CDM log path: '${cdm_log_path}'"
      continue
    fi
    echo "${audit_log_path} ${dot_path}"
    process_cdm_log_to_dot "${cdm_log_path}" "${dot_path}"
  done
}


main_loop
