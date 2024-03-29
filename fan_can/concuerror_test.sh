#!/bin/bash

module=$1
project_name=$(grep "app:" < mix.exs | awk '{print $2}' | tr -d ":,")
elixir_path="/usr/local/lib/elixir"

MIX_ENV=test mix compile

concuerror \
  --pa "${elixir_path}/lib/elixir/ebin" \
  --pa "${elixir_path}/lib/ex_unit/ebin" \
  --pa "_build/test/lib/${project_name}/ebin/" \
  -m "Elixir.${module}" \
  "${@:2}" --graph my_graph.dot --after_timeout 1000 --treat_as_normal shutdown