[![CircleCI](https://dl.circleci.com/status-badge/img/gh/Francis-trillogy/house-prediction/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/Francis-trillogy/house-prediction/tree/main)

## **Project Overview**

In this project, you will apply the skills you have acquired in this course to operationalize a Machine Learning Microservice API.

You are given a pre-trained, `sklearn` model that has been trained to predict housing prices in Boston according to several features, such as average rooms in a home and data about highway access, teacher-to-pupil ratios, and so on. You can read more about the data, which was initially taken from Kaggle, on [the data source site](https://www.kaggle.com/c/boston-housing). This project tests your ability to operationalize a Python flask app—in a provided file, `app.py`—that serves out predictions (inference) about housing prices through API calls. This project could be extended to any pre-trained machine learning model, such as those for image recognition and data labeling.

### **Project Tasks**

Your project goal is to operationalize this working, machine learning microservice using [kubernetes](https://kubernetes.io/), which is an open-source system for automating the management of containerized applications. In this project you will:

* Test your project code using linting
* Complete a Dockerfile to containerize this application
* Deploy your containerized application using Docker and make a prediction
* Improve the log statements in the source code for this application
* Configure Kubernetes and create a Kubernetes cluster
* Deploy a container using Kubernetes and make a prediction
* Upload a complete Github repo with CircleCI to indicate that your code has been tested

#### **Project Steps**

#### **Setup the Environment**

* Create a virtualenv with Python 3.7 and activate it. Refer to this link for help on specifying
the Python version in the virtualenv.

#### **Installing python 3.7 on ubuntu 22.04 [Jammy JellyFish] via terminal**

* Python is a cross-platform programming language, which means that it can run on multiple platforms like Windows, macOS, Linux, and has even been ported to the Java and .NET virtual machines. It is free and open-source

#### **install and configure older versions of Python on Ubuntu 22.04**

* Change the python version to 3.7

[link to installation of older python versions](https://www.how2shout.com/linux/install-python-3-9-or-3-8-on-ubuntu-22-04-lts-jammy-jellyfish/)

#### Creating a virtual env

* The default python version for system is python3.7 hence the virtual environment eco system is based on python3.7

`python3 -m venv ~/.devops`

#### **Activate virtual env**

`source ~/.devops`

#### **MAKEFILE**

* A makefile is a convenction used to encompass a chain of commands to setup, install, test, lint and deploy software. Reduces redudancy.

#### **Commands:**

##### `make install`

    # The command above installs necessary dependencies to our environment which are specified in requirements.txt file
    `pip install --no-cache-dir pip==23.0.1 && pip install --no-cache-dir -r requirements.txt`

##### `make lint`

    # Contains two commands:
    hadolint Dockerfile # check for bugs in a docker file

    pylint --disable=R,C,W1203,W1202 flask-app/predict.py # pylint is a python package which checks on proper formating and syntax errors of .py files

##### Installing Hadolint via curl binary on Local system

    bash
    wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.16.3/hadolint-Linux-x86_64 &&\
    chmod +x /bin/hadolint

#### **Dockefile**

* A Dockerfile is a text document that contains all the commands a user could call on the command line to assemble an image.
* Docker engine and docker desktop should have been installed in the host machine.

#### commands

* Docker image to be used
    FROM python:3.7.3-stretch

#### Step 1: Create a working directory

    WORKDIR /new-app

#### Step 2: Copy source code to working directory

    COPY . flask-app/predict.py /new-app/

#### Step 3: Install packages from requirements.txt

    RUN pip install --no-cache-dir pip==23.0.1 && pip install --no-cache-dir -r requirements.txt

#### Exclude some rules

    hadolint ignore=DL3013 # not used

#### Step 4: Expose port 80

    EXPOSE 80

#### Step 5: Run app.py at container launch

```bash
    CMD ["python","predict.py"]
```

#### **Shell Scripts**

#### **run docker.sh**

* The above script encoposes the following commands.
* commands enable docker to run on local host: Ubuntu 22.04

```bash
#!/usr/bin/env bash
```

#### **Step 1: Build image and add a descriptive tag**

    docker build --tag=predict .

#### **Step 2: List docker images**

    docker image ls

#### **Step 3: Run flask app**

    docker run -p 80:5001 predict

#### Running container and make prediction

* command to run container:

    `./run_docker.sh`

* The above command invokes the docker file to which a docker container is created on the local host.
* A summary of steps that occur once script is run involves:

  * The image is specified in docker file is created, a tag is issued called `predict`.

  * In this stage a docker container is spinned up which refers to an isolated system, dependencies from requirement.txt file are installed. Port 80 is configured a channel to communication from container to host system.
  * Lastly the flask app which was copied over to the docker container is executed and starts to run.
  * One can check browser from the output given from the terminal.

#### **make_prediction**

* command run in terminal:

    `./make_prediction.sh`

  * To run the above execution open a new terminal and execute the command, the script is responsible for sending input data to container where the app runs, a alterations happens such data being organized into a dataframe, its scalled the fed to machine learning an algoritm which in-turn give feedback in-terms of prediction. The model is a supervized machine learning algorithm which explicitly learns from labelled data.
  * A result is given to browser inform of json payload format.
  * The model tries to predict house pricing through various features such as average rooms.
  * Once an output is displayed on terminal press CTR +C in the previous terminal to close the   application from running.

#### Logging and Saving output

* Logging is important for debugging.
* The predict.py application does the following tasks:
  * Accepting an input JSON payload, and converting that into a DataFrame
  * Scaling the DataFrame payload
  * Passing the scaled data to a pre-trained model and getting back a prediction
* Initially the log printed out were JSON and PAYLOAD Dataframes which were not giving much info.
Prediction output wasn't collected and is essential
* Steps to add Prediction log statement are outlined in the `predict.py` file where f-string python type format is used to show output.

#### **Create docker_out.txt**

Copy and paste this terminal output, which has log info, in a text file docker_out.txt

Bellow is a sample of out put
```
[2023-03-07 20:58:22,561] INFO in predict: JSON payload: 
{'CHAS': {'0': 0}, 'RM': {'0': 6.575}, 'TAX': {'0': 296.0}, 'PTRATIO': {'0': 15.3}, 'B': {'0': 396.9}, 'LSTAT': {'0': 4.98}}
[2023-03-07 20:58:22,596] INFO in predict: Inference payload DataFrame: 
   CHAS     RM    TAX  PTRATIO      B  LSTAT
0     0  6.575  296.0     15.3  396.9   4.98
[2023-03-07 20:58:22,607] INFO in predict: Scaling Payload: 
   CHAS     RM    TAX  PTRATIO      B  LSTAT
0     0  6.575  296.0     15.3  396.9   4.98
[2023-03-07 20:58:22,611] INFO in predict: prediction: [20.35373177134412]
172.17.0.1 - - [07/Mar/2023 20:58:22] "POST /predict HTTP/1.1" 200 -
```

The docker_out.txt file should include all your log statements plus a line that reads something like `POST /predict HTTP/1.1 200 -`

#### Upload image

* The above steps invloved running docker locally on local machine.
* Next step is to apload the docker image to docker hub which is a remote hosting site.

    ```
    #!/usr/bin/env bash
    # This file tags and uploads an image to Docker Hub

    # Assumes that an image is built via `run_docker.sh`

    #step 1:
    # create a new tag for the docker image 
    # default tag for image predict is latest 
    # created a public repo on Docker Hub called flask-demo
    docker tag predict:latest francisngethe/flask-demo:predict
    # Step 2:
    # Create dockerpath
    dockerpath=francisngethe/flask-demo:predict
    # Step 3:  
    # Authenticate & tag
    echo "Docker ID and Image: $dockerpath"
    # Step 4:
    # Push image to a docker repository
    docker push francisngethe/flask-demo:predict
    ```

* To invoke the following commands i run in the terminal:

    `./upload.sh`

* to breakdown the steps i created a public repository on docker hub named `francisngethe/flaskdemo as stated above.
* created a new tag to match my remote repo; to note: the image is not generated again its the same image just a different reference in-terms of tag.. This method allows me to supass requirement to login via terminal..
* The last step pushes the image from local docker ecosystem to docker hub where it can be assessed from anywhere is free for public and has pre-loaded machine learning predictive model.


#### **Configure kubernetes and kubectl to run loaclly**

As per project requirements one should have minikube installed and kubectl which is a commandline tool to interact with clusters.

`syntax: minikube start`

Above command spins up minicube environment.

#### **Deploy with Kubernetes and Save Output Logs**


    ```
        #!/usr/bin/env bash

        # This tags and uploads an image to Docker Hub

        # Step 1:
        # This is your Docker ID/path
        dockerpath=francisngethe/flask-demo:predict

        # Step 2
        # Run the Docker Hub container with kubernetes
        # Download the image from Docker Hub
        kubectl run flask-demo --image=francisngethe/flask-demo:predict\
            --port=80 

        # Step 3: 
        # List kubernetes pods
        kubectl get po -A

        # Step 4:
        # Forward the container port to a host
        kubectl port-forward flask-demo 8000:80

        # command to pull docker image
        # docker pull francisngethe/flask-demo:predict

    ```

* The above  shell script pulls image into kuberntes which runs in minikube locally, minikube is a virtual machine which enables us to run kubernetes locally in out host.
* The above code block ensures our application is running, steps are well outlined.
* Making a prediction will give an output since the port is fowarded, out is recorded to kubernetes_output.txt...
* Sample of out is given below

    ```
    Error from server (AlreadyExists): pods "flask-demo" already exists
    NAMESPACE     NAME                               READY   STATUS    RESTARTS      AGE
    default       flask-demo                         1/1     Running   0             22m
    default       test-demo                          1/1     Running   0             41s
    kube-system   coredns-787d4945fb-kcdbr           1/1     Running   0             22m
    kube-system   etcd-minikube                      1/1     Running   0             23m
    kube-system   kube-apiserver-minikube            1/1     Running   0             23m
    kube-system   kube-controller-manager-minikube   1/1     Running   0             23m
    kube-system   kube-proxy-zbvlt                   1/1     Running   0             22m
    kube-system   kube-scheduler-minikube            1/1     Running   0             23m
    kube-system   storage-provisioner                1/1     Running   1 (22m ago)   23m
    Forwarding from 127.0.0.1:8000 -> 80
    Forwarding from [::1]:8000 -> 80

    Port: 80
    "prediction: [20.35373177134412
    ```

* Above are pods running in minikube, `flask-demo` is the image we pulled from docker hub.
* Pods are the smallest deployable units of computing in Kubernetes. They consist of one or more containers, with shared storage and network resources, and a specification for how to run the containers.0 Pods have a few special properties that make them ideal for deploying apps to Kubernetes

#### Release System Resources

* one can delete minikube resources e.g pods
* Command below can be run on terminal

    `minikube delete --all`
