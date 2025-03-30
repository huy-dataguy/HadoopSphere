
# 🚀 HadoopSphere
A fully containerized **Hadoop, Spark, Hive, and Pig** environment for quick and efficient Big Data processing. 

## 🐜 Table of Contents  
- 📚 [My Story](#-my-story-feel-free-to-skip)  
- 👥 [Authors](#-authors)  
- ✨ [Features](#-features)  
- 🔧 [Tech Stack](#-tech-stack)  
- 💻 [OS support](#%EF%B8%8F-os-support) 
- 📌 [Prerequisites](#-prerequisites)  
- 🚀 [Installation Guide](#-installation-guide)  
- 🔄 [Modify the Owner Name](#-modify-the-owner-name)  
- 🌐 [Interact with the Web UI](#-interact-with-the-web-ui)  
- 📞 [Contact](#-contact)  

---

## 📚 **My Story** *(feel free to skip)*  

Setting up a **Hadoop cluster** manually is frustrating, especially when integrating **Spark, Hive, and Pig**. My friend and I initially developed [**HaMu**](https://github.com/DOCUTEE/HaMu) for a simple Hadoop deployment using Docker, and I extended it further by adding **Spark, Hive, and Pig** for full Big Data analytics support.  

💡 I hope **HadoopSphere** helps you quickly set up a Big Data environment for learning and development! 🚀  

---

## 👥 **Authors**  
- [@Quoc Huy Nguyen](https://github.com/huy-dataguy) *(Extended with Spark, Hive, Pig)*  

---

## ✨ **Features**  
👉 Deploy a **multi-node** Hadoop-Spark-Hive-Pig cluster **with a single command**.  
👉 Customize the number of slave nodes.  
👉 Run **HDFS, YARN, Spark, Hive, and Pig** seamlessly inside Docker.  
👉 Access Web UIs for monitoring Hadoop and Spark jobs.  
👉 Use **Hive Metastore with Derby** (or integrate with MySQL/PostgreSQL).  
👉 [Modify the cluster owner's name.](#-modify-the-owner-name)  

---

## 🔧 **Tech Stack**  
- **Hadoop** (HDFS, YARN)  
- **Apache Spark** (Standalone Mode)  
- **Apache Hive** (With Derby Metastore)  
- **Apache Pig**  
- **Docker** (Containerized Setup)  

---

## 🖥️ **OS Support** 
Cross-Platform Compatibility: This project leverages Docker containers, enabling seamless execution across various operating systems, including: 
- 🪟 **Windows** via WSL2 (Windows Subsystem for Linux 2) or Docker Desktop.
- 🐧 **Linux** Ubuntu, CentOS, Debian, and other distributions. 

---

## 📌 **Prerequisites**  
- 🐳 **Docker**  
- 🗃️ **Basic Knowledge of Hadoop, Spark, Hive, Pig**  

---

## 🚀 **Installation Guide**  

### **Step 1: Clone the Repository**  
```sh
git clone https://github.com/huy-dataguy/HadoopSphere.git
cd HadoopSphere
```

### **Step 2: Build Docker Images**  
Building Docker images is required only for the first time or after making changes in the HadoopSphere directory (such as [modifying the owner name](#-modify-the-owner-name)). Make sure Docker is running before proceeding.

> **⏳ Note:** The first build may take a few minutes as no cached layers exist.  

#### 🪟 **For Windows** 
- open wsl or wsl2 
```sh
./linux/build-image.sh
```

#### 🐧 **For Linux**  
```sh
./linux/build-image.sh
```

---

### **Step 3: Start the Cluster**  

#### 🪟 **For Windows**  
- open wsl or wsl2 
```sh
./linux/start-cluster.sh
```

#### 🐧 **For Linux**  
```sh
./linux/start-cluster.sh
```

*By default, this will start a cluster with **1 master and 2 slaves**.*  

To start a cluster with **1 master and 5 slaves**:  
```sh
./linux/start-cluster.sh 6    # 🐧 Linux  
```

---

### **Step 4: Verify the Installation**  

After **Step 3**, you will be inside the **master container's CLI**, where you can interact with the cluster.


💡 **Start the HDFS services:**  
```sh
start-dfs.sh
```
💡 **Check HDFS Nodes**  
```sh
hdfs dfsadmin -report
```
💡 **Start the YARN services:**  
```sh
start-yarn.sh
```
💡 **Check YARN Nodes**  
```sh
yarn node -list
```

💡 **Check Spark Cluster**  
```sh
spark-shell
```

💡 **Check Hive Metastore**  
```sh
hive
```

💡 **Run a Pig Script**  
```sh
pig -x mapreduce
```

📌 Expected Output:
- Check HDFS:
![Deme](https://github.com/user-attachments/assets/a79645b2-84bd-4f7e-aa7b-7bb5bf9474e5)
If you see live DataNodes, your cluster is running successfully. 🚀

- Check YARN:
![yarn](https://github.com/user-attachments/assets/b583412a-7874-481c-80aa-16f84bb0cccd)
If you see live NodeManagers, YARN is running successfully. 🚀

- Check Spark:
![spark](https://github.com/user-attachments/assets/5785493a-f845-47d1-b33b-e95652ba3767)

- Check Hive:
![hive](https://github.com/user-attachments/assets/0e155861-ae20-4a0a-bfe9-effd2efc10a6)

- Check Pig:
![pig](https://github.com/user-attachments/assets/42ea3960-8155-4101-bb00-a5cf1ee5445b)

---


### **Step 5: Test the System with Scripts**  
To verify that the system is working correctly after start hdfs and yarn service, you can run the test scripts.

#### **🔹 Step 1: Navigate to the Scripts Directory**  
```sh
cd scripts 
```

#### **🔹 Step 2: Run a Word Count Test**  
```sh
./word_count.sh
```
This script runs a sample **Word Count** job to ensure that HDFS and YARN are functioning correctly.

---

## **📌 Important Notes on Volumes & Containers**  
Since the system uses **Docker Volumes** for **NameNode and DataNode**, ensure:
- **The number of containers remains the same when restarting** (e.g., if started with 5 slaves, restart with 5 slaves).
- If the number of slaves changes, you may face volume inconsistencies.

✅ **How to Ensure the Correct Number of Containers During Restart**:
1. **Always restart with the same number of containers**:
    ```sh
    ./linux/start-cluster.sh 6  # If you previously used 6 nodes
    ```
2. **Do not delete volumes when stopping the cluster**, use:

#### 🪟 **For Windows**  
- open wsl or wsl2 
```sh
./linux/stop-cluster.sh
```

#### 🐧 **For Linux**  
```sh
./linux/stop-cluster.sh
```
  Avoid using `docker compose -f compose-dynamic.yaml down -v` as it will remove NameNode & DataNode data.

✅ **Check Existing Volumes**:
```sh
docker volume ls | grep hdfs
```


🚀 **If the Word Count job runs successfully, your system is fully operational!**

---

## 🔄 **Modify the Owner Name**  
If you need to change the owner name, run the `rename-owner.py` script and enter your new owner name when prompted.  

> **⏳ Note:** If you want to check the current owner name, it is stored in `OwnerName.txt`.
>
> 📌 There are some limitations; you should use a name that is different from words related to the 'Hadoop' or 'Docker' syntax. For example, avoid names like 'hdfs', 'yarn', 'container', or 'docker-compose'.

```sh
python rename-owner.py
```
---

### 🌐 Interact with the Web UI  

You can access the following web interfaces to monitor and manage your Hadoop cluster:  

- **YARN Resource Manager UI** → [http://localhost:9004](http://localhost:9004)  
  Provides an overview of cluster resource usage, running applications, and job details.  

- **NameNode UI** → [http://localhost:9870](http://localhost:9870)  
  Displays HDFS file system details, block distribution, and overall health status.
- **Spark UI** → [http://localhost:4040](http://localhost:4040)                                                                
  Track Spark jobs, tasks, and execution performance.
---

## 📞 **Contact**  
📧 Email: quochuy.working@gmail.com  

💬 Feel free to contribute and improve this project! 🚀