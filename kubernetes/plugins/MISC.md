# Plugin List
| plugin                      | utility                                                |
| --------------------------- | ------------------------------------------------------ |
| blame                       | show who edited something in resource                  |
| [confirm](#confirm)         | Inform user about where to deploy and what will change |
| [custom-cols](#custom-cols) | get information about some pods specs                  |
| dup                         | duplicate resource (kubectl dup pod private-reg)       |
| [emit-event](#emit-event)   | add event to resource                                  |

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
