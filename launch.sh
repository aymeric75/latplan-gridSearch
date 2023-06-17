#!/bin/bash
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH --gres=gpu:1
#SBATCH --partition=g100_usr_interactive
#SBATCH --account=uBS23_InfGer
#SBATCH --time=08:00:00
#SBATCH --mem=64G
## SBATCH --ntasks-per-socket=1





# ##################
# # SOKOBAN

# exec 1>mysokoban_097.out 2>mysokoban_097.err


# task="sokoban"
# type="sokoban_image-20000-global-global-2-train"
# width_height=""
# nb_examples="20000"
# suffix="without"
# baselabel="sokoban"
# after_sample="sokoban_sokoban_image-20000-global-global-2-train_20000_CubeSpaceAE_AMA4Conv_kltune2"
# pb_subdir="sokoban-2-False"


# conf_folder="05-13T00:51:45.097"
# #conf_folder="05-09T16:42:29.689"
# # conf_folder=05-09T16:42:26.372WITHVARS







###############################
###############################

## BLOCKSWORLD

exec 1>myblocks_grid1.out 2>myblocks_grid1.err

task="blocks"
type="cylinders-4-flat"
width_height=""
nb_examples="20000"
#suffix="with" # = with author's weight, no noisy test init/goal
suffix="without" # = without author's weight, no noisy test init/goal

baselabel="blocks_"$suffix
after_sample="blocks_cylinders-4-flat_20000_CubeSpaceAE_AMA4Conv_kltune2"
pb_subdir="prob-cylinders-4"

conf_folder="06-02T18:03:48.820"

label="blocks_grid2"


##############################################
##############################################


pwdd=$(pwd)

problem_file="ama3_samples_${after_sample}_logs_${conf_folder}_domain_blind_problem.pddl"
domain_dir=samples/$after_sample/grid1/logs/$conf_folder
domain_file=$domain_dir/domain.pddl

problems_dir=problem-generators/backup-propositional/vanilla/$pb_subdir
#problems_dir=problem-generators/vanilla/$pb_subdir # for noisy images



reformat_domain_last() {


    # # reformat domain.pddl
    # sed -i 's/+/plus/' $pwdd/$domain_file
    # sed -i 's/-/moins/' $pwdd/$domain_file
    # sed -i 's/negativemoinspreconditions/negative-preconditions/' $pwdd/$domain_file


    cd ./downward/src/translate
    python main.py $pwdd/$domain_file $pwdd/$current_problems_dir/$problem_file --operation='remove_duplicates'
    cd $pwdd
}



# loop over all the problem dirs, generate the pb.pddl and if
# plan is found then generate sas from it
loop_for_sas_gen() {

    ./clean-problems.sh $pb_subdir

    # generate one problem (used for domain generation)
    #./ama3-planner.py $domain_file $problems_dir/007-000 blind 1
    ./ama3-planner.py $domain_file $current_problems_dir blind 1

    # finish reformating the domain
    current_problems_dir=$problems_dir/007-000 # for reformat_domain_last
    #reformat_domain_last

    ./clean-problems.sh $pb_subdir

    current_problems_dir=$problems_dir # generate_problems
    generate_problems

}


# for dir in samples/$after_sample/logs/*/
# do
#     # echo $dir
#     current_conf_dirr=${dir%*/}
#     echo $current_conf_dirr
#     conf_folder=$(basename $current_conf_dirr)
#     ./train_kltune.py learn $task $type $width_height $nb_examples CubeSpaceAE_AMA4Conv kltune2 --hash $conf_folder
# done

echo "la0"

./train_kltune.py learn $task $type $width_height $nb_examples CubeSpaceAE_AMA4Conv kltune2
exit 0


# ./train_kltune.py dump $task $type $width_height $nb_examples CubeSpaceAE_AMA4Conv kltune2 --hash $conf_folder
# exit 0

# #generate csvs
# ./train_kltune.py dump $task $type $width_height $nb_examples CubeSpaceAE_AMA4Conv kltune2 --hash $conf_folder

#generate domain.pddl

# # echo $pwdd/$domain_dir
# ./pddl-ama3.sh $pwdd/$domain_dir
# exit 0

generate_problems() {
    echo "AA2 "
    ./ama3-planner-all.py $domain_file $current_problems_dir blind 1
    echo "AA3 "
}

# # generate problem
# ./ama3-planner.py $domain_file $problems_dir/007-001 blind 1

# current_problems_dir=$problems_dir


# echo "AAAAAAAAA"

# echo $domain_file


# ./ama3-planner-all.py $domain_file $current_problems_dir blind 1

#loop_for_sas_gen