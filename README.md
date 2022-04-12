# repo-migration
migrate repo from organization to another. Repo descriptions, topics are also migrated automatically.
<br />  
<br />  
<br />   

## Use Guide
use file following the guide. 
1. fix the file based on your needs : (Origin Organization, Target Organization, Repository Name List)
2. Execute the file as the example. 
`bash repo-migration.sh github_user_id github_PAT`
<br />  
<br />  
<br />   



## How I made repo-migration.sh

---
**NOTE**

Some code might include Korean as the validation process was implemented in the environment setting Korean as the default. 

---

<br />   
<br />   

### Project Background
Due to the project trademark issue, migration from the current github organization repositories to the new github organization was needed. 
<br />   
<br />   

### Solution Hypothesis
[Duplicating Repository in GitHub Docs](https://docs.github.com/en/repositories/creating-and-managing-repositories/duplicating-a-repository) <br />
Following the guide above, `git push --mirror` option might be valid for repository migration. 
<br />    
<br />   

### Hypothesis Validation
Before we adjust the solution(`git push --mirror`), experiments were proceeded in my private repo. 

```
git clone --bare https://github.com/*******/integration-test.git
간략한 저장소로('integration-test.git') 복제합니다...
remote: Enumerating objects: 179, done.
remote: Counting objects: 100% (179/179), done.
remote: Compressing objects: 100% (91/91), done.
remote: Total 179 (delta 50), reused 144 (delta 39), pack-reused 0
오브젝트를 받는 중: 100% (179/179), 21.72 KiB | 4.34 MiB/s, 완료.
델타를 알아내는 중: 100% (50/50), 완료.

cd integration-test.git
git push --mirror https://github.com/joon0615/migration_validation_integration-test.git
오브젝트 나열하는 중: 179, 완료.
오브젝트 개수 세는 중: 100% (179/179), 완료.
Delta compression using up to 8 threads
오브젝트 압축하는 중: 100% (80/80), 완료.
오브젝트 쓰는 중: 100% (179/179), 21.72 KiB | 21.72 MiB/s, 완료.
Total 179 (delta 50), reused 179 (delta 50), pack-reused 0
remote: Resolving deltas: 100% (50/50), done.
To https://github.com/joon0615/migration_validation_integration-test.git
 * [new branch]      master -&gt; master
 * [new tag]         v1.0.2 -&gt; v1.0.2
 * [new tag]         v1.0.3 -&gt; v1.0.3
 * [new tag]         v1.0.3-dev4 
```

<br />   
As a result, source code and commit history was migrated, but 2 problems were discovered.

1. About section in the repository, the description and topics were not migrated.
2. Issue, Pull Requests were not migrated.

<br />   
<br />   

### Alternative Research
[Github Importer Guide in GitHub Docs](https://docs.github.com/en/get-started/importing-your-projects-to-github/importing-source-code-to-github/importing-a-repository-with-github-importer)
<br />   

Another validation process for this alternative (GitHub Importer) was completed, but the limits found in `git push --mirror` option were not solved. 
<br />   
<br />   
<br />   

## Solution through detour
<br />   
<br />   

### 1. About Section(Description, Topic) Migration
Before using the option `git push --mirror`, new repository should be generated as the migration target in new organization. During the generation process of new repositoy, we can add description and replace the topics data fetched from the old repository by API. As the document shows below, validation was successful. Therefore, repo-migration.sh could be implemented.

<br />   
<br />   

Description migration process can be validated through the experiment described in the code showed below. 
<br />   
```
DESCRIPTION=$(curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/*********/migration-test-0404 | grep description)
echo $DESCRIPTION
>>> "description": "test repo for migration",

curl -X POST -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/orgs/**********/repos \
  -d '{"name":"migration-test-0404", "description":"test repo for migration"}' \
  -u "joon0615:*********************"
{
  "id": 477564217,
  "node_id": "R_kgDOHHcNOQ",
  "name": "migration-test-0404",
  "full_name": "********/migration-test-0404",
  "private": false,
  ...
}
```
<br />   
<br />   

Related Resources are introduced below. 
<br />   
- [Get all repository lists - GitHub Docs](https://docs.github.com/en/rest/reference/repos#list-organization-repositories)
- [Get repository description - GitHub Docs](https://docs.github.com/en/rest/reference/repos#get-a-repository)
- [Include User Authentication option in Repository Creation - GitHub Docs](https://docs.github.com/en/rest/guides/getting-started-with-the-rest-api#using-personal-access-tokens)
- [Create New Repository - GitHub Docs](https://docs.github.com/en/rest/reference/repos#create-an-organization-repository)

<br />   
<br />   
<br />   

Topic migration process can be validated through the experiment described in the code showed below. 
<br />   

```
curl -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/repos/***********/console/topics
{
  "names": [
    "core",
    "console",
    "vue",
    "composition-api",
    "vuejs",
    "dashboard"
  ]

curl -X PUT -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/repos/*********/migration-test-0404/topics \
  -d '{"names":["test", "console"]}' \ 
  -u "joon0615:********************"

{
  "names": [
    "test",
    "console"
  ]
}
```
<br />   
<br />   

Related Resources are introduced below. 
<br />   

- [Get Repository Topics - GitHub Docs](https://docs.github.com/en/rest/reference/repos#get-all-repository-topics)
- [Replace the new repository topics - GitHub Docs](https://docs.github.com/en/rest/reference/repos#replace-all-repository-topics)

<br />   
<br />   
<br />   

### Issue, PR Migration
There are two options found for migrating PRs and issues. 
<br />   
<br />   

1. Transferring Issues
<br />   

As the option indicates no replication, it would be hard to restore from the migration failure. Related document can be found [here](https://docs.github.com/en/issues/tracking-your-work-with-issues/transferring-an-issue-to-another-repository).

<br />   
<br />   
<br />   

2. Read the former repositories' issues and Add to the new repositories
<br />   
This option seems safer than the former option in the perspective of resilience, but the contents such as the timestamp of the issues may be changed. 
<br />   
<br />   

Related Resources are introduced below. 
<br />   

- [Listing the issues from the repository - GitHub Docs](https://docs.github.com/en/rest/reference/issues#list-repository-issues)
- [Creating new issues - GitHub Docs](https://docs.github.com/en/rest/reference/issues#create-an-issue)

<br />   
<br />   
<br />   

### Additional Subject to Consider

Related to the terms of issues and pull requests, the object of this migration includes the GitHub Project(Beta funciton) board. However, since the feature is on beta, GitHub does not provide API for the feature, therefore it might require some manual tasks to re-create the board in the new organization. To check about the related article, visit [here](https://docs.github.com/en/rest/reference/projects).

