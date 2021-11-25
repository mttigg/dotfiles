#!/bin/bash

branch_name=''
function getBranch() {
  branch_name=$(git symbolic-ref -q HEAD)
  branch_name=${branch_name##refs/heads/}
  branch_name=${branch_name:-HEAD}
}
# Nova, commands to follow here
function nova() {
  #  novaBase
  case $1 in
  hi)
    get_emoji "hi"
    echo "Hello! Lets get you setup!"
    start_ssh_agent
    if [ $LOCAL_ENVIRONMENT ]; then
      npx kill-port 5022

      connect_bastion
    else
      npm run start:dev
    fi
    ;;
  asdf)
    get_emoji "ded"
    echo "What am I going to do with that?"
    ;;
  git)
    get_emoji "nerd"
    echo "Gitter done"
    case $2 in
    push)
      echo "Pushin 4 u <3"
      getBranch
      sleep 1
      echo "Pushin $branch_name to origin"
      git push --set-upstream origin $branch_name
      get_emoji "workin"
      echo "Pushed :)"
      ;;
    pull)
      echo "pullllll"
      getBranch
      sleep 1
      echo "Pullin $branch_name to local"
      git fetch origin
      git pull
      get_emoji "workin"
      echo "Up to date"
      ;;
    checkout)
      echo "Checkin u out"
      sleep 1
      echo "Checking out $3"
      git fetch origin
      git checkout $3
      get_emoji "workin"
      echo "Branch checked out!"
      ;;
    esac
    ;;
  sync)
    get_emoji "sync"
    echo "Sync..."
    case $2 in
    local)
      if [ $LOCAL_ENVIRONMENT ]; then
        echo "Matching local with remote 4 u <3"
        sleep 1
        rsync -avz --exclude=node_modules --exclude=.git --exclude=.github --exclude=packages/police-cruiser/node_modules --exclude=packages/red-tail/node_modules --exclude=packages/red-tail/public --exclude=packages/hammer-head/node_modules --exclude=packages/hammer-head/dist --exclude=packages/hammer-head/.idea --exclude=.idea -e "ssh -p 5022" ec2-user@localhost:/home/ec2-user/hangar-bay/ ./ || failed
        get_emoji "synced"
        echo "local shouuuuld now match remote"

      else
        get_emoji "mad"
        echo "Can't be done on the remote dummy"
      fi
      ;;
    remote)
      if [ $LOCAL_ENVIRONMENT ]; then
        echo "Matching remote with local 4 u <3"
        sleep 1
        rsync -avz --exclude=node_modules --exclude=.git --exclude=.github --exclude=packages/police-cruiser/node_modules --exclude=packages/red-tail/node_modules --exclude=packages/red-tail/public --exclude=packages/hammer-head/node_modules --exclude=packages/hammer-head/dist --exclude=packages/hammer-head/.idea --exclude=.idea -e "ssh -p 5022" ./ ec2-user@localhost:/home/ec2-user/hangar-bay/ || failed
        get_emoji "synced"
        echo "remote shouuuld now match local"

      else
        get_emoji "mad"
        echo "Can't be done on the remote dummy"
      fi
      ;;
    esac
    ;;
  *)
    echo "y no command?"
    ;;
  esac
}

function start_ssh_agent() {
  echo "Starting ssh-agent..."
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/$DEV_KEY_NAME
  ssh-add ~/.ssh/$BASTION_KEY_NAME
  ssh-add ~/.ssh/$GIT_KEY_NAME
  echo "ssh-agent started..."
}

function connect_bastion() {
  echo "connecting to bastion"...
  ssh -L 5022:$dev_ip:22 ec2-user@$bastion_ip -N -A -f
  echo "ssh tunnel complete"
}

function failed() {
  get_emoji 'ded'
  echo "Command Failed!"
}

function get_emoji() {
  emojis=("ヽ༼၀-၀༽ﾉ" "༼･ิɷ･ิ༽" "༼≖ɷ≖༽" "༼ ꉺˇɷˇꉺ ༽" "༼;´༎ຶ ༎ຶ ༽" "༼ ⌐■ل͟■ ༽" "ヽ༼ ಢ_ಢ ༽ﾉ" "༼ : ౦ ‸ ౦ : ༽" "୧༼ ' ✖ ‸ ✖ ' ༽୨" "༼ ♥ل͜♥ ༽" "୧༼✿ ͡◕ д ◕͡ ༽୨" "⋌༼ •̀ ⌂ •́ ༽⋋" "乁༼☯‿☯✿༽ㄏ" "୧༼ ヘ ᗜ ヘ ༽୨")
  case $1 in
  normal)
    echo $emojis[0]
    ;;
  ded)
    echo $emojis[9]
    ;;
  workin)
    echo $emojis[14]
    ;;
  hi)
    echo $emojis[13]
    ;;
  nerd)
    echo $emojis[6]
    ;;
  sync)
    echo $emojis[10]
    ;;
  synced)
    echo $emojis[7]
    ;;
  mad)
    echo $emojis[11]
    ;;
  *)
    echo " $filename : Not processed"
    ;;
  esac
}
