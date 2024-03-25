#!/bin/bash

# Inspired by https://stackoverflow.com/questions/50242293/using-sbatch-job-name-as-a-variable-in-file-output
userMe="herman"
userRCC="ha16d"
fileToRun="$1.py"
jobScript="$1.sh"

# Set the work directory, workDir
if [ $USER = $userMe ]
then
     workDir="/Users/$USER/Documents"
     pythonDir="$workDir/dis2001"
     shellsDir="$workDir/HPC Jobs"
elif [ $USER = $userRCC ]
then
     workDir="/gpfs/home/$USER"
     pythonDir="$workDir/foose"
     shellsDir="$workDir/foose/HPC Jobs"
fi

# Disclaimer
echo "Using relative paths from $workDir!"

# Make sure python file exists for that name
if [ ! -d "$pythonDir/$fileToRun" ]
then
     echo "The file \"$fileToRun\" does not exist in \"$pythonDir\""
     exit 1
fi

# Make sure directory exists for SLURM outputs. Each SBATCH script has its own directory.
if [ ! -d "$workDir/slurm/$1" ]
then
     mkdir "$workDir/slurm/$1"
fi

# Write SBATCH script with appropriate jobnames
echo "#!/bin/bash" > $jobScript
echo "#SBATCH --job-name=\"$1\"" >> $jobScript
echo "#SBATCH -e slurm/$1/job-%j.err" >> $jobScript
echo "#SBATCH -o slurm/$1/job-%j.out" >> $jobScript
echo "#SBATCH -c 4" >> $jobScript
echo "#SBATCH -n 1" >> $jobScript
echo "#SBATCH --mem=12G" >> $jobScript
echo "##SBATCH --gres=gpu:1" >> $jobScript
echo "#SBATCH --mail-type=\"ALL\"" >> $jobScript
echo "#SBATCH -t 01:00:00  #days-hours:minutes:seconds" >> $jobScript

# Not sure what this does
echo "srun mycommand" >> $jobScript

# Actual job code
echo "python3 -u \"$shellsDir/$1\"" >> $jobScript

#submit the job
sbatch "$jobScript"
