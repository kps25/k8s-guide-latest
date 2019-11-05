$ kubectl run sample-nginx --image=nginx --replicas=2 --port=80
$ kubectl get pods

NAME                       READY     STATUS    RESTARTS   AGE
sample-nginx-379829228-xb9y3   1/1       Running   0          10s
sample-nginx-379829228-yhd25   1/1       Running   0          10s

$ kubectl get deployments

NAME       DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
sample-nginx   2         2         2            2           29s


============================

kubectl expose deployment sample-nginx --port=80 --type=LoadBalancer

$ kubectl get services -o wide

NAME         CLUSTER-IP      EXTERNAL-IP                                                              PORT(S)   AGE       SELECTOR
kubernetes   100.64.0.1      <none>                                                                   443/TCP   25m       <none>
sample-nginx     100.70.129.69   adca6650a60e611e7a66612ae64874d4-175711331.us-east-1.elb.amazonaws.com/   80/TCP    19m       run=sample-nginx


There is an ELB running on http://adca6650a60e611e7a66612ae64874d4-175711331.us-east-1.elb.amazonaws.com with our nginx containers behind it:
