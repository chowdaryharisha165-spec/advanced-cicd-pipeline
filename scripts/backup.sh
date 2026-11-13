#!/bin/bash
mkdir -p backups && tar -czf backups/app-backup-$(date +%F).tar.gz application/ docker/ kubernetes/

