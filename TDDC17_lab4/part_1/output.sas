begin_version
3
end_version
begin_metric
0
end_metric
10
begin_variable
var0
-1
3
Atom at(boxa, rooma)
Atom at(boxa, roomb)
Atom at(boxa, roomc)
end_variable
begin_variable
var1
-1
3
Atom at-shakey(rooma)
Atom at-shakey(roomb)
Atom at-shakey(roomc)
end_variable
begin_variable
var2
-1
2
Atom free(left)
NegatedAtom free(left)
end_variable
begin_variable
var3
-1
2
Atom free(right)
NegatedAtom free(right)
end_variable
begin_variable
var4
-1
2
Atom lightswitch-on(switcha)
NegatedAtom lightswitch-on(switcha)
end_variable
begin_variable
var5
-1
2
Atom lightswitch-on(switchb)
NegatedAtom lightswitch-on(switchb)
end_variable
begin_variable
var6
-1
2
Atom lightswitch-on(switchc)
NegatedAtom lightswitch-on(switchc)
end_variable
begin_variable
var7
-1
5
Atom at(blockx, rooma)
Atom at(blockx, roomb)
Atom at(blockx, roomc)
Atom carry(blockx, left)
Atom carry(blockx, right)
end_variable
begin_variable
var8
-1
5
Atom at(blocky, rooma)
Atom at(blocky, roomb)
Atom at(blocky, roomc)
Atom carry(blocky, left)
Atom carry(blocky, right)
end_variable
begin_variable
var9
-1
5
Atom at(blockz, rooma)
Atom at(blockz, roomb)
Atom at(blockz, roomc)
Atom carry(blockz, left)
Atom carry(blockz, right)
end_variable
2
begin_mutex_group
4
7 3
8 3
9 3
2 0
end_mutex_group
begin_mutex_group
4
7 4
8 4
9 4
3 0
end_mutex_group
begin_state
2
0
0
0
1
1
1
1
2
2
end_state
begin_goal
7
1 0
4 0
5 1
6 1
7 0
8 0
9 0
end_goal
58
begin_operator
drop blockx rooma left
1
1 0
2
0 7 3 0
0 2 -1 0
1
end_operator
begin_operator
drop blockx rooma right
1
1 0
2
0 7 4 0
0 3 -1 0
1
end_operator
begin_operator
drop blockx roomb left
1
1 1
2
0 7 3 1
0 2 -1 0
1
end_operator
begin_operator
drop blockx roomb right
1
1 1
2
0 7 4 1
0 3 -1 0
1
end_operator
begin_operator
drop blockx roomc left
1
1 2
2
0 7 3 2
0 2 -1 0
1
end_operator
begin_operator
drop blockx roomc right
1
1 2
2
0 7 4 2
0 3 -1 0
1
end_operator
begin_operator
drop blocky rooma left
1
1 0
2
0 8 3 0
0 2 -1 0
1
end_operator
begin_operator
drop blocky rooma right
1
1 0
2
0 8 4 0
0 3 -1 0
1
end_operator
begin_operator
drop blocky roomb left
1
1 1
2
0 8 3 1
0 2 -1 0
1
end_operator
begin_operator
drop blocky roomb right
1
1 1
2
0 8 4 1
0 3 -1 0
1
end_operator
begin_operator
drop blocky roomc left
1
1 2
2
0 8 3 2
0 2 -1 0
1
end_operator
begin_operator
drop blocky roomc right
1
1 2
2
0 8 4 2
0 3 -1 0
1
end_operator
begin_operator
drop blockz rooma left
1
1 0
2
0 9 3 0
0 2 -1 0
1
end_operator
begin_operator
drop blockz rooma right
1
1 0
2
0 9 4 0
0 3 -1 0
1
end_operator
begin_operator
drop blockz roomb left
1
1 1
2
0 9 3 1
0 2 -1 0
1
end_operator
begin_operator
drop blockz roomb right
1
1 1
2
0 9 4 1
0 3 -1 0
1
end_operator
begin_operator
drop blockz roomc left
1
1 2
2
0 9 3 2
0 2 -1 0
1
end_operator
begin_operator
drop blockz roomc right
1
1 2
2
0 9 4 2
0 3 -1 0
1
end_operator
begin_operator
move rooma roomb wideab
0
1
0 1 0 1
1
end_operator
begin_operator
move roomb rooma wideab
0
1
0 1 1 0
1
end_operator
begin_operator
move roomb roomc narrowbc
0
1
0 1 1 2
1
end_operator
begin_operator
move roomb roomc widebc
0
1
0 1 1 2
1
end_operator
begin_operator
move roomc roomb narrowbc
0
1
0 1 2 1
1
end_operator
begin_operator
move roomc roomb widebc
0
1
0 1 2 1
1
end_operator
begin_operator
pick blockx rooma left switcha
2
1 0
4 0
2
0 7 0 3
0 2 0 1
1
end_operator
begin_operator
pick blockx rooma right switcha
2
1 0
4 0
2
0 7 0 4
0 3 0 1
1
end_operator
begin_operator
pick blockx roomb left switchb
2
1 1
5 0
2
0 7 1 3
0 2 0 1
1
end_operator
begin_operator
pick blockx roomb right switchb
2
1 1
5 0
2
0 7 1 4
0 3 0 1
1
end_operator
begin_operator
pick blockx roomc left switchc
2
1 2
6 0
2
0 7 2 3
0 2 0 1
1
end_operator
begin_operator
pick blockx roomc right switchc
2
1 2
6 0
2
0 7 2 4
0 3 0 1
1
end_operator
begin_operator
pick blocky rooma left switcha
2
1 0
4 0
2
0 8 0 3
0 2 0 1
1
end_operator
begin_operator
pick blocky rooma right switcha
2
1 0
4 0
2
0 8 0 4
0 3 0 1
1
end_operator
begin_operator
pick blocky roomb left switchb
2
1 1
5 0
2
0 8 1 3
0 2 0 1
1
end_operator
begin_operator
pick blocky roomb right switchb
2
1 1
5 0
2
0 8 1 4
0 3 0 1
1
end_operator
begin_operator
pick blocky roomc left switchc
2
1 2
6 0
2
0 8 2 3
0 2 0 1
1
end_operator
begin_operator
pick blocky roomc right switchc
2
1 2
6 0
2
0 8 2 4
0 3 0 1
1
end_operator
begin_operator
pick blockz rooma left switcha
2
1 0
4 0
2
0 9 0 3
0 2 0 1
1
end_operator
begin_operator
pick blockz rooma right switcha
2
1 0
4 0
2
0 9 0 4
0 3 0 1
1
end_operator
begin_operator
pick blockz roomb left switchb
2
1 1
5 0
2
0 9 1 3
0 2 0 1
1
end_operator
begin_operator
pick blockz roomb right switchb
2
1 1
5 0
2
0 9 1 4
0 3 0 1
1
end_operator
begin_operator
pick blockz roomc left switchc
2
1 2
6 0
2
0 9 2 3
0 2 0 1
1
end_operator
begin_operator
pick blockz roomc right switchc
2
1 2
6 0
2
0 9 2 4
0 3 0 1
1
end_operator
begin_operator
push rooma roomb boxa wideab
0
2
0 0 0 1
0 1 0 1
1
end_operator
begin_operator
push roomb rooma boxa wideab
0
2
0 0 1 0
0 1 1 0
1
end_operator
begin_operator
push roomb roomc boxa widebc
0
2
0 0 1 2
0 1 1 2
1
end_operator
begin_operator
push roomc roomb boxa widebc
0
2
0 0 2 1
0 1 2 1
1
end_operator
begin_operator
turn_light_off rooma boxa switcha left
3
0 0
1 0
2 0
1
0 4 0 1
1
end_operator
begin_operator
turn_light_off rooma boxa switcha right
3
0 0
1 0
3 0
1
0 4 0 1
1
end_operator
begin_operator
turn_light_off roomb boxa switchb left
3
0 1
1 1
2 0
1
0 5 0 1
1
end_operator
begin_operator
turn_light_off roomb boxa switchb right
3
0 1
1 1
3 0
1
0 5 0 1
1
end_operator
begin_operator
turn_light_off roomc boxa switchc left
3
0 2
1 2
2 0
1
0 6 0 1
1
end_operator
begin_operator
turn_light_off roomc boxa switchc right
3
0 2
1 2
3 0
1
0 6 0 1
1
end_operator
begin_operator
turn_light_on rooma boxa switcha left
3
0 0
1 0
2 0
1
0 4 1 0
1
end_operator
begin_operator
turn_light_on rooma boxa switcha right
3
0 0
1 0
3 0
1
0 4 1 0
1
end_operator
begin_operator
turn_light_on roomb boxa switchb left
3
0 1
1 1
2 0
1
0 5 1 0
1
end_operator
begin_operator
turn_light_on roomb boxa switchb right
3
0 1
1 1
3 0
1
0 5 1 0
1
end_operator
begin_operator
turn_light_on roomc boxa switchc left
3
0 2
1 2
2 0
1
0 6 1 0
1
end_operator
begin_operator
turn_light_on roomc boxa switchc right
3
0 2
1 2
3 0
1
0 6 1 0
1
end_operator
0
