## Keywords
- rbac
- access
- auth
- permissions
- user
# Plugin List
| plugin                          | utility                                        |
| ------------------------------- | ---------------------------------------------- |
| [access-matrix](#access-matrix) | Show all rbac for current users or other users |
|                                 |                                                |

## Commands
### access-matrix
- **Current User Access:** kubectl access-matrix  
- **Sepecify SA:** kubectl access-matrix --sa kube-system:namespace-controller
- **Sepecify User Access:** kubectl access-matrix --as prometheu