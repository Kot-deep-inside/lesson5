-module(lesson5_task1).
-export([compare/0]).

compare() ->
    Mechanisms = [ets, maps],
    Operations = [insert, update, delete, read],
    Results = [{Mechanism, Op, run_test(Mechanism, Op)} || Mechanism <- Mechanisms, Op <- Operations],
    io:format("Results: ~p~n", [Results]).

run_test(ets, insert) ->
    ets:new(test_table, [named_table]),
    timer:tc(fun() -> lists:foreach(fun(N) -> ets:insert(test_table, {N, N * 2}) end, lists:seq(1, 1000)) end);
run_test(ets, update) ->
    timer:tc(fun() -> lists:foreach(fun(N) -> ets:insert(test_table, {N, N * 3}) end, lists:seq(1, 1000)) end);
run_test(ets, delete) ->
    timer:tc(fun() -> lists:foreach(fun(N) -> ets:delete(test_table, N) end, lists:seq(1, 1000)) end);
run_test(ets, read) ->
    timer:tc(fun() -> lists:foreach(fun(N) -> ets:lookup(test_table, N) end, lists:seq(1, 1000)) end);

run_test(maps, insert) ->
    timer:tc(fun() -> lists:foldl(fun(N, Acc) -> maps:put(N, N * 2, Acc) end, #{}, lists:seq(1, 1000)) end);
run_test(maps, update) ->
    timer:tc(fun() -> lists:foldl(fun(N, Acc) -> maps:put(N, N * 3, Acc) end, #{}, lists:seq(1, 1000)) end);
run_test(maps, delete) ->
    timer:tc(fun() -> lists:foldl(fun(N, Acc) -> maps:remove(N, Acc) end, #{}, lists:seq(1, 1000)) end);
run_test(maps, read) ->
    timer:tc(fun() -> lists:foreach(fun(N) -> maps:get(N, #{}) end, lists:seq(1, 1000)) end).
