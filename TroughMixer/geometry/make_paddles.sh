#!/bin/bash

rm -rf work
mkdir work

surfaceTransformPoints -yawPitchRoll '(0 45 0)' paddle.stl work/paddle_A.stl
surfaceTransformPoints -yawPitchRoll '(0 0 180)' work/paddle_A.stl work/paddle_B.stl

cat work/paddle_{A,B}.stl > work/paddlePair_A.stl
rm work/paddle_{A,B}.stl

surfaceTransformPoints -yawPitchRoll '(90 0 0)' work/paddlePair_A.stl work/paddlePair_B.stl
surfaceTransformPoints -yawPitchRoll '(0 0 90)' work/paddlePair_B.stl work/paddlePair_B.stl

surfaceTransformPoints -translate   '(0 0 .05)' work/paddlePair_A.stl work/paddlePair_A0.stl
surfaceTransformPoints -translate   '(0 0 .15)' work/paddlePair_B.stl work/paddlePair_B0.stl
rm work/paddlePair_{A,B}.stl

for i in `seq 1 9`
do
    surfaceTransformPoints -translate '(0 0 .2)' work/paddlePair_A$(expr $i - 1).stl work/paddlePair_A$i.stl
    surfaceTransformPoints -translate '(0 0 .2)' work/paddlePair_B$(expr $i - 1).stl work/paddlePair_B$i.stl
done




echo "solid solid"               > mixing_assembly.stl
sed '/solid solid/d' work/*.stl >> mixing_assembly.stl
sed '/solid solid/d' axle.stl   >> mixing_assembly.stl
echo "endsolid solid"           >> mixing_assembly.stl

rm -rf work
