# Network Monitoring Engineering Challenge

## Task 1: Random Number Generator

### Description
This project contains a pure Bash script (`random_numbers.sh`) that outputs the numbers from 1 to 10 in a random order, ensuring each number appears only once. 

To strictly stick to the "bash only" constraint, this script intentionally avoids external GNU utilities (such as `shuf`, `sort -R`, or `seq`). Instead, it uses the **Fisher-Yates shuffle algorithm** using native Bash arrays and the internal `$RANDOM` variable. Following, a test script (`test_script.sh`) is also provided to validate the script's core logic and output.

### Build Instructions
As these are interpreted Bash scripts, there is no need for compilation or traditional build process required. To prepare the scripts for execution, simply grant them the necessary permissions using:

`chmod +x random_numbers.sh test_script.sh`

### Usage
**To run the main generator:**
`./random_numbers.sh`

**To run the test:**
`./test_script.sh`

*Note: The test verifies that the output contains exactly 10 lines, contains zero duplicate numbers, and that the mathematical sum of the output is exactly 55.*

### Known Limitations / Bugs
* **Pseudo-Randomness:** The script relies on Bash's internal `$RANDOM` function. This is a pseudo-random number generator (PRNG) seeded by the system clock and the PID. While perfectly sufficient for general scripting and this specific challenge, it is not cryptographically secure.
* **Performance at Scale:** Because this implementation uses pure, built-in Bash loops and variable swapping to satisfy the tool constraints, it is meant for small data sets (like 1-10). If the requirement were to scale to millions of integers, compiled utilities (like `shuf`) would be more memory and CPU efficient.


## Task 2: Server Monitoring Architecture

### Scenario Overview
The objective is to monitor a proxy server handling SSL offloading for roughly 25,000 requests per second. The server has 4x Intel Xeon CPUs, 64GB RAM, a 2TB HDD, and 2x 10Gbit/s network cards.

### 1. Key Metrics to Monitor
For a high-traffic proxy server, I would focus on monitoring the following key areas:

* **CPU Usage:** SSL/TLS encryption requires a lot of processing power. I would monitor overall CPU usage to ensure the 4 CPUs aren't maxing out under the heavy load.
* **Disk I/O:** Since the server uses a 2TB HDD (a mechanical drive) instead of an SSD, monitoring disk write speeds and disk **latency** (I/O wait times) is very important to make sure the disk isn't slowing down the system.
* **Network Traffic:** Monitoring incoming and outgoing bandwidth (Gbps) to ensure we aren't hitting the limits of the 10Gbit/s network cards.
* **Application Metrics:** We need to track the exact Requests Per Second (**RPS**), request **latency** (how fast the proxy replies to users), and HTTP error rates (like 502 Bad Gateway) to ensure the proxy is serving traffic successfully.

### 2. How to Monitor
A standard and effective industry approach is using **Prometheus and Grafana**:

* **Collection (Prometheus):** I would install an agent like `node_exporter` on the server to gather hardware stats (CPU, RAM, Disk). I would also use a web-specific exporter (like the Nginx exporter) to gather application stats like **RPS** and active connections.
* **Visualization (Grafana):** Prometheus would collect these metrics, and Grafana would visualize them on dashboards, making it easy for the NOC team to spot traffic spikes or high **latency**.
* **Alerting:** Proactive **alerting** is critical. I would set up automated alerts to notify the team immediately if the CPU stays above 85% for too long, if **latency** spikes abnormally, or if the HTTP 5xx error rate crosses a certain threshold.

### 3. Challenges of Monitoring This Server
* **The Hard Drive Bottleneck:** The biggest challenge is the 2TB HDD. Mechanical hard drives have relatively slow read/write speeds. If the server tries to write a traditional access log to the disk for every single request at 25,000 **RPS**, the disk will become overloaded. A solution would be to reduce log verbosity, buffer logs in memory, or send them over the network to a central logging server.
* **High CPU Load from SSL:** Handling 25,000 SSL handshakes per second is heavy on the processor. It can be challenging to configure **alerting** so that it correctly distinguishes between a legitimate traffic surge and a volumetric DDoS attack trying to exhaust the server's resources.
