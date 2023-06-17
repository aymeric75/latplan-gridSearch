#!/bin/bash

pwdd=$(pwd)


# #################
# SOKOBAN 

exec 1>myblocks_stats.out 2>myblocks_stats.err
task="blocks"
type="cylinders-4-flat"
width_height=""
nb_examples="20000"
suffix="without" # = without author's weight, no noisy test init/goal
baselabel="blocks_"$suffix
after_sample="blocks_cylinders-4-flat_20000_CubeSpaceAE_AMA4Conv_kltune2"
conf_folder="05-02T13:16:14.247Bisz0z3By2"
label="blocks_877"
after_sample="blocks_cylinders-4-flat_20000_CubeSpaceAE_AMA4Conv_kltune2"


domains_dirs=samples/blocks_cylinders-4-flat_20000_CubeSpaceAE_AMA4Conv_kltune2/grid1/logs
probs_subdir=prob-cylinders-4

# 1) Put all the probs to already filled subdirectories (the ones where you have the domain.pddl)
for dir in $domains_dirs/*/
do
    #if ! [[ "$(basename $dir)" == "05-09T21:55:56.585" ]]; then
    current_dir=$(basename $dir)
    echo $dir
    # cp -r problem-generators/backup-propositional/vanilla/$probs_subdir $dir
    # cd $dir/$probs_subdir
    # find . -type f -not -name '*.png' -delete
    # find . -type f -name 'ama3*' -delete
    # cd $pwdd

    #fi
done


# # 2) Now the loop (same) but this time generate the domain.pddl
# for dir in $domains_dirs/*/
# do
#     ./train_kltune.py dump $task $type $width_height $nb_examples CubeSpaceAE_AMA4Conv kltune2 --hash $dir
#     ./pddl-ama3.sh $dir
# done



# # 3) finally again same loop but this time : use the domain.pddl and go over the 
# #   pbs (using ama3-planner-all.py)


# for dir in $domains_dirs/*/
# do
#     echo ${dir}domain.pddl
#     echo $probs_subdir
    
#     ./ama3-planner-all.py $dir/domain.pddl $dir/$probs_subdir blind 1
#     exit 0
# done

# AND take the number of found solutions AND write them in a fresh json
# THEN produce the last json (combination with the latter)
##### FINALLY  a script that will go through all the jsons and make the stats
#cp -r problem-generators/backup-propositional/vanilla/$probs_subdir domains_dirs


# for dir in $domains_dirs/*/
# do

#     nb_sols=$(find $dir -mindepth 1 -type f -name "*.plan" -exec printf x \; | wc -c)
#     echo $nb_sols > nb_sols.txt

#     # 
#     ./new-json-and-test-xhi.py $dir

# done


# create a new json file