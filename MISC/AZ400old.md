## Table of Contents
Just put [NAME of first title] () it will auto-complete itself.
- [Understand DevOps](#understand-devops)
  - [Understand your cycle time](#understand-your-cycle-time)
  - [DevOps Journey](#devops-journey)
- [Planning for DevOps](#planning-for-devops)
  - [DevOps Transformation](#devops-transformation)
- [DevOps project selection](#devops-project-selection)
  - [Get better feedback (Users types)](#get-better-feedback-users-types)
- [DevOps Team structure](#devops-team-structure)
  - [Waterfall Approach](#waterfall-approach)
  - [Agile](#agile)
- [What can Azure DevOps do](#what-can-azure-devops-do)
- [Migrating to Azure DevOps](#migrating-to-azure-devops)
- [Version Control](#version-control)
  - [Centralized](#centralized)
  - [Distributed](#distributed)
# Understand DevOps
## Understand your cycle time
![alt](Images/Optimized%20Validated%20Learning.jpg)
This step help us get the value of improvement
1. Objective
2. Orient
3. Decide
4. Act

--> (Validated learning) Decide one of the following then repeat
- Good 
- Neutral
- BAD

## DevOps Journey
![alt](Images/DevOps%20CI.jpg)
![alt](Images/DevOps%20CD.jpg)
![alt](Images/DevOps%20Version%20control.jpg)
![alt](Images/Agile%20and%20Scrum.jpg)
![alt](Images/Monitor%20and%20log.jpg)
![alt](Images/Clouds.jpg)
![alt](Images/IAC.jpg)
![alt](Images/Microservice%20arch.jpg)
![alt](Images/Containerization.jpg)

# Planning for DevOps
## DevOps Transformation
- Ensure Availability of DevOps members
- Prevent Disruption of processes and tasks
- Add internal and external members (get new external knowledge)
- Results should be measurables, for example reduce MTTR to 60% by calculting difference in time etc...

# DevOps project selection
| Type        | Description  | Info                                                                                                              | DevOps Friendly                                               |
| ----------- | ------------ | ----------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------- |
| Green Field | new projects | Easy to implement best practices politics and advanced solutions                                                  | It is so compatible with devops practices                     |
| Brown Field | old projects | Harder to maintain and implement new practices because it requires so much time (related to delivery to end user) | No but will sometimes require devops approach for reliability |


there are two types Systems:
- System of records (secure accurate and truth about data an things taken slowly to make sure things are perfect)
- System of engagement (focused more about research and implementing new things and solve new problems) usually focus on doing things quickly to deliver faster
## Get better feedback (Users types)
When deploying apps you will need to understand which users should see the new features first and we have 3 examples:
- Canaries
- Early Adopters
- Users

| Type           | info                                                       |
| -------------- | ---------------------------------------------------------- |
| Canaries       | Test features after they re available                      |
| Early Adopters | Preview releases and code that canary users are exposed to |
| Users          | Are normal users (final end users)                         |


# DevOps Team structure
## Waterfall Approach
Hard to accurately define requirements since the project must sometimes require updates in goals and objectives, focus on long term achievements.
## Agile
Ensure continuous delivery of versions and features where it's based on iterations and focused on short term achievements (including documentation and best practices...) known for flexibility.
![alt](Images/Principles%20of%20Agile%20dev.jpg)

We should pick the right tools for team's productivity and value, such as for:
* scrum (tickets/tasks) tools like azure devops or jira
* Communication tools like teams and slack
* monitoring tools like grafana and kibana...
* release management tools like jenkins

# What can Azure DevOps do
Platform for dev and deploying software
- azure boards (agile planning)
- Azure pipelines (ci cd platform)
- Azure repos (git scm)
- Azure Artifacts (integrated packed management) mvn, python, npm, nuget packages ...
- Azure Test plans (for integrated plans)

# Migrating to Azure DevOps
There are integrations to migrate for example jira or trello boards to azure devops boards, test plans like from jmeter and pester into azure devops test plans ...

# Version Control
## Centralized
Tools Tracks codes changes from centralized source (users work on same source which is centralized), example of centralized source (TFVC, Subversion..)
## Distributed
Examples (mercurial, git ...) 
Does not rely on a central server, every dev clone a copy and have their own version and have history and all metadeta