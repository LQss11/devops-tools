# Plugin List
| plugin                      | utility                                                                               |
| --------------------------- | ------------------------------------------------------------------------------------- |
| blame    ⭐                  | show who edited something in resource                                                 |
| [confirm](#confirm)         | Inform user about where to deploy and what will change                                |
| [custom-cols](#custom-cols) | get information about some pods specs                                                 |
| dup                         | duplicate resource (kubectl dup pod private-reg)                                      |
| change-ns                   | change namespace of current cluster                                                   |
| [emit-event](#emit-event)   | add event to resource                                                                 |
| example   ⭐                 | prints example manifests (kubectl example configmap like kubectl explain --recursive) |
| explore                     | explore all fields in al resources (like kubectl explain --recursive)                 |
| fields                      | get fields info   (example to get all images fieldskubectl fields deploy imag)        |
| fleet                       | get info about a set of clusters in your kubeconfig                                   |
| foreach                     | run same command on multiple clusters (kubectl foreach -- get nodes)                  |
| [fuzzy](#fuzzy) ⭐           | run/exec command and it will scan pods for you interactive                            |
| get-all                     | get all resources even the ones that are not in kubectl get all                       |
| [graph](#graph)             | create a graph based on some resources                                                |
| [history](#history) ⭐       | get history of revisions of resources                                                 |
| [ice](#ice) ⭐               | get important information and configs about containers in pods                        |
| kc                          | manage contexts and kubeconfig files and create config files with roles               |

## Commands
### confirm
- kubectl confirm apply -f ./deploy.yaml
### custom-cols
- kubectl custom-cols -o images pods -A
- kubectl custom-cols -o annotations pods -A
- kubectl custom-cols -o resources pods -A
- kubectl custom-cols -o node-pod pods -A
- **Here are some templates you can use:** annotations, finalizers, images, limits, node-pod, qos-class, requests, resources
### emit-event
- could be used for monitoring or adding events on a resource on purpose
- kubectl  emit-event deploy/nginx-deployment --reason xxx --message mymessage --type Normal
### fuzzy
- kubectl fuzzy logs -f -P -A
- kubectl fuzzy delete deploy -P -A
- kubectl fuzzy describe pod -P -A
- kubectl fuzzy exec -P -A -it -- sh 
### graph
- must first install a graph creator tool like graphviz you can install **sudo apt-get install graphviz**
- run to generate graph: **kubectl graph all | dot -T svg -o /tmp/all.svg**
- for better vis but a bit advanced follow [this docs](https://github.com/steveteuber/kubectl-graph)
### history
- **list current revisions** kubectl history list deploy nginx
- **latest:** kubectl history diff deploy nginx
- **between revisions:** kubectl history diff deploy nginx 84 86
### ice
- **get all probes** kubectl ice probes