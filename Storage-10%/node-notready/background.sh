#!/bin/bash

ssh node01
systemctl stop kubelet.service
exit