
# Migration to IRBcluster set up
## General bashrc configuration

First, set up bashrc file in the IRB cluster to be able to run conda, qmap and jupyter. 

1. Connect to the cluster:

  ```bash
ssh <user>@irblogin01.irbbarcelona.pcb.ub.es
```
*Tip*: add to your `~/.ssh/config` file in local to create a shortcut. 
 ```bash
host irbc
hostname irblogin01.irbbarcelona.pcb.ub.es
user mgrau
```
1. Once logged in, create the bash profile (`~/.bash_profile`):
```bash
# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi
```
3. Then edit your bashrc (`~/.bashrc`)):
```bash
export CONDA_ENVS_PATH=/home/bbg/mgrau/apps/miniconda3.7/envs/
export PATH=/home/mgrau/.local/bin/:$PATH
export QMAP_PROFILE=/home/mgrau/.config/qmap/qmap_slurm.conf
alias interactive='salloc --qos=long -c 1 --mem=8G --time=30-00:00:00 -p bbg_cpu_zen4'
alias sac='sacct --user=$USER --state=COMPLETED --starttime=$(date -d "30 days ago" +%Y-%m-%d)
--endtime=now --format=JobID,JobName,State,Partition,ReqMem,MaxRSS,AllocCPUS,Elapsed,TimeLimit,End
--parsable2 | awk -F"|" '"'"'BEGIN { printf "%-12s %-60s %-10s %-12s %-8s %-10s %-8s %-12s %-12s
%-20s\n", "JobID", "JobName", "State", "Partition", "ReqMem", "MaxRSS", "CPUs", "Elapsed", "TimeLimit",
"End" } { if ($1 !~ /\./) { jobid = $1; jobname = $2; state = $3; partition = $4; reqmem = $5; cpus =
$7; elapsed = $8; timelimit = $9; end = $10; maxrss = "" } if ($1 ~ /\.batch$/) { maxrss = $6; if
(maxrss ~ /K$/) { maxrss_value = substr(maxrss, 1, length(maxrss)-1) / 1048576; maxrss =
sprintf("%.2fG", maxrss_value) } printf "%-12s %-60s %-10s %-12s %-8s %-10s %-8s %-12s %-12s %-20s\n",
jobid, jobname, state, partition, reqmem, maxrss, cpus, elapsed, timelimit, end } }'"'"' | tail -n 30'
alias sq='squeue --user=mgrau --format="%.18i %.9P %.8j %.8u %.2t %.10M %.6D %.10Q %.10C %.10m %.10l
%.6b %.8q %.10r"'
```

 !!! info Note that you can find a copy of all these configuration files in the IRB cluster `/data/bbg/nobackup/scratch/IRB_cluster` 

4. To modify prompt appearance (add colours and path) add the following in ``bashrc`` file:
```bashrc
# color scheme terminal
color_prompt=yes
force_color_prompt=yes

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}[${STY}] \[\033[01;95m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
```

5. Set up colour prompt when running screens:
```bash
# color scheme terminal
color_prompt=yes
force_color_prompt=yes

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}[${STY}] \[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    # PS1="\e[33m[$(date +"%T")]\e\ \e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
```
6. If you want to be able to scroll using screens add a `screen_rc` file in your home containing the following:
```bash
termcapinfo xterm* ti@:te@
termcapinfo xterm* ti@:te@
```

## Configure qmap

  Install using the most recent branch:
  ```bash
  git clone -b fix/slurm23.02.1_compatible
git@github.com:bbglab/qmap.git
2.cd qmap/ && pip install
```
** missing jupyter (already in bbgwiki?)
## Add credentials
To avoid entering password everytime you access to the IRB cluster

## Working with conda environments


## Git configuration from old repos in the bbgcluster
Since the ``HOME`` has changed in the IRB cluster, git settings do not know where to find the keys from old repos set up in the bbgcluster. So you have 2 options:
- Option1: Create another key to the new ``HOME`` and set up everything (find instructions [here](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)).
- Option 2: Copy the entire ``~/.ssh`` folder from the "old home" to the new one although you might need to check the .git config in the bbgcluster.

## Usage of rsync
  
(modify to add that rsync only works outside screens and add option to copy larger files outside a screen)


## Reference
- Elisabet Figuerola
- Raquel Blanco