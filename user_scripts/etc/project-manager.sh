#!/bin/bash

DIR=~/Documents/OtherProjects/expenses_tracker

kitty --detach --working-directory=$DIR sh -c "nvim plan.md"
kitty --detach --working-directory=$DIR sh -c "nvim ."
kitty --detach --working-directory=$DIR sh -c "claude -c"
kitty --detach --working-directory=$DIR/backend
