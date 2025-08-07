#!/bin/bash

LOG_FILE="/tmp/borgsteve/apache_logs"

if [[ ! -f "$LOG_FILE" ]]; then
    echo "Error: Log file '$LOG_FILE' not found."
    exit 1
fi

while true; do
    echo "Log Analysis Menu"
    echo "1) Count total requests"
    echo "2) Find IP with most requests"
    echo "3) Count number of 404 errors"
    echo "4) Run all"
    echo "5) Exit"
    read -rp "Choose an option [1-5]: " choice

    case $choice in
        1)
            total_requests=$(wc -l < "$LOG_FILE")
            echo "Total requests: $total_requests"
            ;;
        2)
            most_active_ip=$(awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -1 | awk '{print $2}')
            echo "Most active IP: $most_active_ip"
            ;;
        3)
            count_404=$(awk '$9 == 404' "$LOG_FILE" | wc -l)
            echo "Number of 404 errors: $count_404"
            ;;
        4)
            total_requests=$(wc -l < "$LOG_FILE")
            most_active_ip=$(awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -1 | awk '{print $2}')
            count_404=$(awk '$9 == 404' "$LOG_FILE" | wc -l)
            echo "Total requests: $total_requests"
            echo "Most active IP: $most_active_ip"
            echo "Number of 404 errors: $count_404"
            ;;
        5)
            echo "Exiting."
            break
            ;;
        *)
            echo "Invalid option. Please enter a number between 1 and 5."
            ;;
    esac

    echo ""
done
