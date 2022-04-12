# repo-migration
migrate repo from organization to another. Repo descriptions, topics are also migrated automatically.

<h3 data-pm-slice="0 0 []" data-ke-size="size23"><b>Use Guide</b></h3>

use file following the guide. 
1. fix the file based on your needs : (Origin Organization, Target Organization, Repository Name List)

2. Execute the file as the example. 
`bash repo-migration.sh github_user_id github_PAT`


<p data-pm-slice="0 0 []" data-ke-size="size16">&nbsp;</p>
<h3 data-pm-slice="0 0 []" data-ke-size="size23"><b>배경</b></h3>
<p data-pm-slice="0 0 []" data-ke-size="size16">프로젝트의 상표권 문제 등으로 기존 운영 Organization을 새로운 이름의 Organization으로 마이그레이션을 해야 하는 상황을 맞이해, 기존에 운영하던 100개 이상의 레포지토리들을 새로운 곳으로 옮겨줘야 하는 문제가 발생했다. 이를 해결하기 위해 깃헙 레포지토리들을 옮기는 방법들에 대해 공부할 겸 포스트를 정리했다.&nbsp;</p>
<p data-pm-slice="0 0 []" data-ke-size="size16">&nbsp;</p>
<p data-pm-slice="0 0 []" data-ke-size="size16">&nbsp;</p>

<h3 data-pm-slice="0 0 []" data-ke-size="size23"><b>해결책에 대한 가설</b></h3>
<p data-pm-slice="0 0 []" data-ke-size="size16"><a href="https://docs.github.com/en/repositories/creating-and-managing-repositories/duplicating-a-repository" target="_blank" rel="noopener">https://docs.github.com/en/repositories/creating-and-managing-repositories/duplicating-a-repository</a></p>
<figure id="og_1649074331812" contenteditable="false" data-ke-type="opengraph" data-ke-align="alignCenter" data-og-type="article" data-og-title="Duplicating a repository - GitHub Docs" data-og-description="Note: If you have a project hosted on another version control system, you can automatically import your project to GitHub using the GitHub Importer tool. For more information, see &quot;About GitHub Importer.&quot; Before you can push the original repository to your" data-og-host="docs.github.com" data-og-source-url="https://docs.github.com/en/repositories/creating-and-managing-repositories/duplicating-a-repository" data-og-url="http://ghdocs-prod.azurewebsites.net:80/en/repositories/creating-and-managing-repositories/duplicating-a-repository" data-og-image="https://scrap.kakaocdn.net/dn/bdXBpl/hyNVSLPT1j/uFB8kvKy23t7W1mabOIWzk/img.png?width=1200&amp;height=1200&amp;face=0_0_1200_1200"><a href="https://docs.github.com/en/repositories/creating-and-managing-repositories/duplicating-a-repository" target="_blank" rel="noopener" data-source-url="https://docs.github.com/en/repositories/creating-and-managing-repositories/duplicating-a-repository">
<div class="og-image" style="background-image: url('https://scrap.kakaocdn.net/dn/bdXBpl/hyNVSLPT1j/uFB8kvKy23t7W1mabOIWzk/img.png?width=1200&amp;height=1200&amp;face=0_0_1200_1200');">&nbsp;</div>
<div class="og-text">
<p class="og-title" data-ke-size="size16">Duplicating a repository - GitHub Docs</p>
<p class="og-desc" data-ke-size="size16">Note: If you have a project hosted on another version control system, you can automatically import your project to GitHub using the GitHub Importer tool. For more information, see "About GitHub Importer." Before you can push the original repository to your</p>
<p class="og-host" data-ke-size="size16">docs.github.com</p>
</div>
</a></figure>
<p data-pm-slice="0 0 []" data-ke-size="size16">&nbsp;</p>
<p data-pm-slice="0 0 []" data-ke-size="size16"><span style="background-color: #9feec3;"><b>다음 문서의 가이드에 따라 git push --mirror 옵션을 활용해볼 예정이다.&nbsp;</b></span></p>
<p data-pm-slice="0 0 []" data-ke-size="size16">&nbsp;</p>
<p data-pm-slice="0 0 []" data-ke-size="size16">&nbsp;</p>
<p data-pm-slice="0 0 []" data-ke-size="size16">&nbsp;</p>
<p data-pm-slice="0 0 []" data-ke-size="size16">&nbsp;</p>
<h3 data-pm-slice="0 0 []" data-ke-size="size23"><b>가설 검증</b></h3>
<p data-ke-size="size16">우선 전체 Organization에 직접 적용하기 이전에 개인 레포로 복제해보는 검증 작업을 진행해보았다.&nbsp;</p>
<p data-ke-size="size16">&nbsp;</p>
<pre id="code_1649074457167" class="shell" data-ke-language="shell" data-ke-type="codeblock"><code>git clone --bare https://github.com/*******/integration-test.git
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
 * [new tag]         v1.0.3-dev4 -&gt; v1.0.3-dev4</code></pre>
<p data-ke-size="size16">&nbsp;</p>
<p data-ke-size="size16">검증 작업 결과 소스코드와 커밋 기록은 성공적으로 복제되었다.</p>
<p data-ke-size="size16">&nbsp;</p>
<p data-ke-size="size16">그러나, 크게 2가지 문제가 발생했다.&nbsp;</p>
<p data-ke-size="size16">&nbsp;</p>
<p data-ke-size="size16"><span style="background-color: #f6e199;"><b>1. 레포지토리 별 About 항목, Description과 Topic이 옮겨지지 않는다.&nbsp;</b></span></p>
<p data-ke-size="size16"><span style="background-color: #f6e199;"><b>2. 레포지토리 별 Issue, PR 등이 옮겨지지 않는다.&nbsp;</b></span></p>
<p data-pm-slice="0 0 []" data-ke-size="size16">&nbsp;</p>
<p data-pm-slice="0 0 []" data-ke-size="size16">&nbsp;</p>
<p data-pm-slice="0 0 []" data-ke-size="size16">&nbsp;</p>
<p data-pm-slice="0 0 []" data-ke-size="size16">&nbsp;</p>
<h3 data-pm-slice="0 0 []" data-ke-size="size23"><b>대안 탐색</b></h3>
<p data-ke-size="size16"><a href="https://docs.github.com/en/get-started/importing-your-projects-to-github/importing-source-code-to-github/importing-a-repository-with-github-importer" target="_blank" rel="noopener">https://docs.github.com/en/get-started/importing-your-projects-to-github/importing-source-code-to-github/importing-a-repository-with-github-importer</a></p>
<figure id="og_1649074564774" contenteditable="false" data-ke-type="opengraph" data-ke-align="alignCenter" data-og-type="article" data-og-title="Importing a repository with GitHub Importer - GitHub Docs" data-og-description="Tip: GitHub Importer is not suitable for all imports. For example, if your existing code is hosted on a private network, our tool won't be able to access it. In these cases, we recommend importing using the command line for Git repositories or an external " data-og-host="docs.github.com" data-og-source-url="https://docs.github.com/en/get-started/importing-your-projects-to-github/importing-source-code-to-github/importing-a-repository-with-github-importer" data-og-url="https://docs.github.com/en/get-started/importing-your-projects-to-github/importing-source-code-to-github/importing-a-repository-with-github-importer" data-og-image="https://scrap.kakaocdn.net/dn/2wEHG/hyNVJH8yL8/G1dDCO8rIRMIxpSFYKneK1/img.png?width=1200&amp;height=1200&amp;face=0_0_1200_1200,https://scrap.kakaocdn.net/dn/mLXTX/hyNVIvF0Pg/RkC23Y9wo8TKoKk5n6lIm0/img.png?width=564&amp;height=312&amp;face=0_0_564_312,https://scrap.kakaocdn.net/dn/tng4P/hyNVOvTjBT/CkwAG9eYKqvl7UlpHZuJVK/img.png?width=430&amp;height=300&amp;face=0_0_430_300"><a href="https://docs.github.com/en/get-started/importing-your-projects-to-github/importing-source-code-to-github/importing-a-repository-with-github-importer" target="_blank" rel="noopener" data-source-url="https://docs.github.com/en/get-started/importing-your-projects-to-github/importing-source-code-to-github/importing-a-repository-with-github-importer">
<div class="og-image" style="background-image: url('https://scrap.kakaocdn.net/dn/2wEHG/hyNVJH8yL8/G1dDCO8rIRMIxpSFYKneK1/img.png?width=1200&amp;height=1200&amp;face=0_0_1200_1200,https://scrap.kakaocdn.net/dn/mLXTX/hyNVIvF0Pg/RkC23Y9wo8TKoKk5n6lIm0/img.png?width=564&amp;height=312&amp;face=0_0_564_312,https://scrap.kakaocdn.net/dn/tng4P/hyNVOvTjBT/CkwAG9eYKqvl7UlpHZuJVK/img.png?width=430&amp;height=300&amp;face=0_0_430_300');">&nbsp;</div>
<div class="og-text">
<p class="og-title" data-ke-size="size16">Importing a repository with GitHub Importer - GitHub Docs</p>
<p class="og-desc" data-ke-size="size16">Tip: GitHub Importer is not suitable for all imports. For example, if your existing code is hosted on a private network, our tool won't be able to access it. In these cases, we recommend importing using the command line for Git repositories or an external</p>
<p class="og-host" data-ke-size="size16">docs.github.com</p>
</div>
</a></figure>
<p data-ke-size="size16">git push --mirror 옵션의 한계를 극복할 다른 레포 복제 수단으로 GitHub Importer를 활용하여 검증을 재차 수행했으나, 위의 문제들은 동일하게 반복되었다.&nbsp;</p>
<p data-ke-size="size16">&nbsp;</p>
<p data-ke-size="size16">&nbsp;</p>
<p data-ke-size="size16">&nbsp;</p>
<p data-ke-size="size16">&nbsp;</p>
<h3 data-ke-size="size23"><b>문제의 우회적 해결</b></h3>
<p data-ke-size="size16">&nbsp;</p>
<h4 data-ke-size="size20"><b>About 항목 (Description, Topic) 복제</b></h4>
<p data-ke-size="size16">git push --mirror 옵션 사용 전, 옮길 위치에 신규 레포지토리를 생성해야 하므로, 그 생성 과정에서 기존 레포지토리의 description과 topic 데이터를 api로 가져와 추가하는 방식을 통해 우회적으로 해결 가능하다. 검증 작업을 걸쳐 실현 가능성을 검토해보니 성공적이었으므로, 마이그레이션 작업 시 관련 스크립트를 작성해 자동화하면 될 것으로 예상한다.&nbsp;</p>
<p data-ke-size="size16">&nbsp;</p>
<p data-ke-size="size16"><span style="background-color: #f6e199;"><b>우선 description 관련 검증 작업을 진행했다.&nbsp;</b></span></p>
<pre id="code_1649074896352" class="shell" data-ke-language="shell" data-ke-type="codeblock"><code>DESCRIPTION=$(curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/*********/migration-test-0404 | grep description)
echo $DESCRIPTION
&gt;&gt;&gt; "description": "test repo for migration",

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
}</code></pre>
<p data-ke-size="size16">&nbsp;</p>
<p data-ke-size="size16"><b>참고한 자료는 다음과 같다.&nbsp;</b></p>
<ul style="list-style-type: disc;" data-indent-level="3" data-ke-list-type="disc">
<li>기존 레포지토리 리스트 가져오기 : <span data-inline-card="true" data-card-url="https://docs.github.com/en/rest/reference/repos#list-organization-repositories"><span><a href="https://docs.github.com/en/rest/reference/repos#list-organization-repositories" data-testid="inline-card-resolved-view"><span><span></span><span>Repositories - GitHub Docs</span></span></a></span></span></li>
<li>기존 레포지토리 디스크립션 가져오기 : <span data-inline-card="true" data-card-url="https://docs.github.com/en/rest/reference/repos#get-a-repository"><span><a href="https://docs.github.com/en/rest/reference/repos#get-a-repository" data-testid="inline-card-resolved-view"><span><span></span><span>Repositories - GitHub Docs</span></span></a></span></span></li>
<li>레포지토리 생성 시 인증 이슈 관련 옵션 추가 : <span data-inline-card="true" data-card-url="https://docs.github.com/en/rest/guides/getting-started-with-the-rest-api#using-personal-access-tokens"><span><a href="https://docs.github.com/en/rest/guides/getting-started-with-the-rest-api#using-personal-access-tokens" data-testid="inline-card-resolved-view"><span><span></span><span>Getting started with the REST API - GitHub Docs</span></span></a></span></span></li>
<li>신규 레포지토리 생성 : <span data-inline-card="true" data-card-url="https://docs.github.com/en/rest/reference/repos#create-an-organization-repository"><span><a href="https://docs.github.com/en/rest/reference/repos#create-an-organization-repository" data-testid="inline-card-resolved-view"><span><span></span><span>Repositories - GitHub Docs</span></span></a></span></span></li>
</ul>
<p data-ke-size="size16">&nbsp;</p>
<p data-ke-size="size16">&nbsp;</p>
<p data-ke-size="size16"><span style="background-color: #f6e199;"><b>다음으로 topic 관련 검증 작업을 진행했다.&nbsp; </b></span></p>
<pre id="code_1649075038260" class="shell" data-ke-language="shell" data-ke-type="codeblock"><code>curl -H "Accept: application/vnd.github.v3+json" \
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
}</code></pre>
<p data-ke-size="size16">&nbsp;</p>
<p data-ke-size="size16"><b>참고한 자료는 다음과 같다.&nbsp;</b></p>
<ul style="list-style-type: disc;" data-indent-level="3" data-ke-list-type="disc">
<li>기존 레포지토리 토픽 가져오기 : <span data-inline-card="true" data-card-url="https://docs.github.com/en/rest/reference/repos#get-all-repository-topics"><span><a href="https://docs.github.com/en/rest/reference/repos#get-all-repository-topics" data-testid="inline-card-resolved-view"><span><span></span><span>Repositories - GitHub Docs</span></span></a></span></span></li>
<li>신규 레포지토리 토픽 교체 : <span data-inline-card="true" data-card-url="https://docs.github.com/en/rest/reference/repos#replace-all-repository-topics"><span><a href="https://docs.github.com/en/rest/reference/repos#replace-all-repository-topics" data-testid="inline-card-resolved-view"><span><span></span><span>Repositories - GitHub Docs</span></span></a></span></span></li>
</ul>
<p data-ke-size="size16">&nbsp;</p>
<p data-ke-size="size16">&nbsp;</p>
<p data-ke-size="size16">&nbsp;</p>
<h4 data-ke-size="size20"><b>Issue, PR 복제</b></h4>
<p data-ke-size="size16">이슈를 옮기는 작업은 크게 2가지 방법이 있을 수 있다.&nbsp;</p>
<p data-ke-size="size16">&nbsp;</p>
<p data-ke-size="size16"><span style="background-color: #f6e199;"><b>1. 이슈를 Transfer하는 것이다. </b></span></p>
<p data-ke-size="size16">복제가 아닌 바로 옮기는 방식이기 때문에 작업 실패 시 복원 작업의 어려움이 예상된다.&nbsp;</p>
<p data-ke-size="size16">&nbsp;</p>
<p data-ke-size="size16"><a href="https://docs.github.com/en/issues/tracking-your-work-with-issues/transferring-an-issue-to-another-repository" target="_blank" rel="noopener">https://docs.github.com/en/issues/tracking-your-work-with-issues/transferring-an-issue-to-another-repository</a></p>
<figure id="og_1649075143247" contenteditable="false" data-ke-type="opengraph" data-ke-align="alignCenter" data-og-type="article" data-og-title="Transferring an issue to another repository - GitHub Docs" data-og-description="To transfer an open issue to another repository, you must have write access to the repository the issue is in and the repository you're transferring the issue to. For more information, see &quot;Repository roles for an organization.&quot; Note: You can only transfer" data-og-host="docs.github.com" data-og-source-url="https://docs.github.com/en/issues/tracking-your-work-with-issues/transferring-an-issue-to-another-repository" data-og-url="http://ghdocs-prod.azurewebsites.net:80/en/issues/tracking-your-work-with-issues/transferring-an-issue-to-another-repository" data-og-image="https://scrap.kakaocdn.net/dn/H3RNB/hyNUwDCSzn/bELJkcr9Gcqj6X64mAJXIK/img.png?width=1200&amp;height=1200&amp;face=0_0_1200_1200,https://scrap.kakaocdn.net/dn/qlnXx/hyNUxvK7HD/pW6fVRrg3sTjNFKwi3akY0/img.png?width=1888&amp;height=234&amp;face=0_0_1888_234"><a href="https://docs.github.com/en/issues/tracking-your-work-with-issues/transferring-an-issue-to-another-repository" target="_blank" rel="noopener" data-source-url="https://docs.github.com/en/issues/tracking-your-work-with-issues/transferring-an-issue-to-another-repository">
<div class="og-image" style="background-image: url('https://scrap.kakaocdn.net/dn/H3RNB/hyNUwDCSzn/bELJkcr9Gcqj6X64mAJXIK/img.png?width=1200&amp;height=1200&amp;face=0_0_1200_1200,https://scrap.kakaocdn.net/dn/qlnXx/hyNUxvK7HD/pW6fVRrg3sTjNFKwi3akY0/img.png?width=1888&amp;height=234&amp;face=0_0_1888_234');">&nbsp;</div>
<div class="og-text">
<p class="og-title" data-ke-size="size16">Transferring an issue to another repository - GitHub Docs</p>
<p class="og-desc" data-ke-size="size16">To transfer an open issue to another repository, you must have write access to the repository the issue is in and the repository you're transferring the issue to. For more information, see "Repository roles for an organization." Note: You can only transfer</p>
<p class="og-host" data-ke-size="size16">docs.github.com</p>
</div>
</a></figure>
<p data-ke-size="size16">&nbsp;</p>
<p data-ke-size="size16">&nbsp;</p>
<p data-ke-size="size16"><span style="background-color: #9feec3;"><b>2. 기존 레포지토리 이슈를 읽어와 새로운 레포지토리에 새롭게 생성해주는 것이다. [채택]</b></span></p>
<p data-ke-size="size16">보다 안전한 방법이지만, 기존 내용의 타임스탬프 등이 어그러질 확률이 있다. 안정성을 중시하기 때문에 2안으로 진행 예정이다.&nbsp;</p>
<p data-ke-size="size16">&nbsp;</p>
<p data-ke-size="size16"><b>참고할 자료는 다음과 같다.</b></p>
<ul style="list-style-type: disc;" data-indent-level="2" data-ke-list-type="disc">
<li>기존 레포 이슈 리스트업 : <span data-inline-card="true" data-card-url="https://docs.github.com/en/rest/reference/issues#list-repository-issues"><span><a href="https://docs.github.com/en/rest/reference/issues#list-repository-issues" data-testid="inline-card-resolved-view"><span><span></span><span>Issues - GitHub Docs</span></span></a></span></span></li>
<li>신규 이슈 생성 : <span data-inline-card="true" data-card-url="https://docs.github.com/en/rest/reference/issues#create-an-issue"><span><a href="https://docs.github.com/en/rest/reference/issues#create-an-issue" data-testid="inline-card-resolved-view"><span><span></span><span>Issues - GitHub Docs</span></span></a></span></span></li>
</ul>
<p data-ke-size="size16">&nbsp;</p>
<p data-ke-size="size16">이슈 및 풀리퀘스트와 관련해서는 한가지 더 고려할 바가 있다. 현재 운영 중인 레포들은 깃헙 프로젝트(베타) 기능으로 보드를 운영 중인데, 이것이 이슈로 연동되어 있다는 특징이 있다. 더군다나 베타 기능이라 API 호출도 안되는 것으로 확인된다. 이는 별도 해결안이 보이지 않아 아마 수동 작업으로 복원하지 않을까 싶다.&nbsp;</p>
<p data-ke-size="size16"><a href="https://docs.github.com/en/rest/reference/projects" target="_blank" rel="noopener">https://docs.github.com/en/rest/reference/projects</a></p>
<figure id="og_1649075349250" contenteditable="false" data-ke-type="opengraph" data-ke-align="alignCenter" data-og-type="article" data-og-title="Projects - GitHub Docs" data-og-description="Projects The Projects API lets you create, list, update, delete and customize projects in a repository. List organization projects Lists the projects in an organization. Returns a 404 Not Found status if projects are disabled in the organization. If you do" data-og-host="docs.github.com" data-og-source-url="https://docs.github.com/en/rest/reference/projects" data-og-url="http://ghdocs-prod.azurewebsites.net:80/en/rest/reference/projects" data-og-image="https://scrap.kakaocdn.net/dn/pLmW3/hyNVMdMHFt/uak8PLEcN3MvWnkVkNgIZ0/img.png?width=1200&amp;height=1200&amp;face=0_0_1200_1200"><a href="https://docs.github.com/en/rest/reference/projects" target="_blank" rel="noopener" data-source-url="https://docs.github.com/en/rest/reference/projects">
<div class="og-image" style="background-image: url('https://scrap.kakaocdn.net/dn/pLmW3/hyNVMdMHFt/uak8PLEcN3MvWnkVkNgIZ0/img.png?width=1200&amp;height=1200&amp;face=0_0_1200_1200');">&nbsp;</div>
<div class="og-text">
<p class="og-title" data-ke-size="size16">Projects - GitHub Docs</p>
<p class="og-desc" data-ke-size="size16">Projects The Projects API lets you create, list, update, delete and customize projects in a repository. List organization projects Lists the projects in an organization. Returns a 404 Not Found status if projects are disabled in the organization. If you do</p>
<p class="og-host" data-ke-size="size16">docs.github.com</p>
</div>
</a></figure>
<p data-pm-slice="0 0 []" data-ke-size="size16">&nbsp;</p>
