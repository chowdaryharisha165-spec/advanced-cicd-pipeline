#!/usr/bin/env python3
import sys
import re

def analyze_incident(log_text):
    print("=" * 55)
    print("    AI-ASSISTED INCIDENT & ROOT CAUSE ANALYSIS    ")
    print("=" * 55)

    if re.search(r'timeout|connection refused|failed to connect', log_text, re.IGNORECASE):
        print("Incident Type     : Database Connection Timeout / Failure")
        print("Incident Severity : CRITICAL")
        print("Possible Cause    : Database connectivity / configuration issue or DB service down")
        print("\nSuggested Investigation:")
        print("  [x] Check Database availability & Pod status")
        print("  [x] Verify Network connectivity & Security Groups / NetworkPolicies")
        print("  [x] Check DB credentials in ConfigMap / Secrets")
        print("  [x] Monitor connection limits and pool exhaustion")
    elif re.search(r'404|not found', log_text, re.IGNORECASE):
        print("Incident Type     : Resource / Route Not Found")
        print("Incident Severity : LOW")
        print("Possible Cause    : Incorrect Ingress path or missing static assets")
        print("\nSuggested Investigation:")
        print("  [x] Check Ingress rules and service routing configuration")
    elif re.search(r'out of memory|oomkilled|heap', log_text, re.IGNORECASE):
        print("Incident Type     : Resource Exhaustion (OOM)")
        print("Incident Severity : HIGH")
        print("Possible Cause    : Memory leak or container memory limits set too low")
        print("\nSuggested Investigation:")
        print("  [x] Inspect Kubernetes resource limits (limits.memory)")
        print("  [x] Analyze Node memory utilization with Prometheus/Grafana")
    else:
        print("Incident Type     : General Application Exception")
        print("Incident Severity : MEDIUM")
        print("Possible Cause    : Unhandled runtime error")
        print("\nSuggested Investigation:")
        print("  [x] Inspect complete stack trace in ELK / container logs")

    print("=" * 55)

if __name__ == '__main__':
    if len(sys.argv) > 1:
        log_input = " ".join(sys.argv[1:])
    else:
        log_input = "ERROR: Database Connection Timeout while connecting to port 5432"
    
    print(f"\n[Raw Incident Log]: {log_input}\n")
    analyze_incident(log_input)
