<!DOCTYPE html>
<html>
  <head>
    <title>Helm Charts</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/x-icon" href="/images/favicon-152.png">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/2.10.0/github-markdown.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/brands.min.css" integrity="sha512-nS1/hdh2b0U8SeA8tlo7QblY6rY6C+MgkZIeRzJQQvMsFfMQFUKp+cgMN2Uuy+OtbQ4RoLMIlO2iF7bIEY3Oyg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
      .body {
        background-color: #303030;
      }
      .markdown-body {
        box-sizing: border-box;
        min-width: 200px;
        margin: 0 auto;
        padding: 45px;
        color: #dedede;
      }

      .markdown-body a {
        color: #a3d0f5;
      }

      @media (max-width: 767px) {
        .markdown-body {
          padding: 15px;
        }
      }
      .markdown-body pre {
        background-color: #282c34;
      }
 
      .time {
        color: #dedede;
      }
      .githublogo {
        color: #fff;
        text-align: right;
      }

      div.tags {
        justify-content: center;
        text-align: center;
        display: flex;
      }

      p.tags {
        position: absolute;
        bottom: 0;
        font-size: 75%
      }

      span.tags {
       display: inline-block;
       line-height: 2em;
       position: relative;
        
       padding: 0 10px 0 12px;
       background: #507aa5;
       -webkit-border-bottom-right-radius: 3px;
       border-bottom-right-radius: 3px;
       -webkit-border-top-right-radius: 3px;
       border-top-right-radius: 3px;
       -webkit-border-bottom-left-radius: 3px;
       border-bottom-left-radius: 3px;
       -webkit-border-top-left-radius: 3px;
       border-top-left-radius: 3px;
       -webkit-box-shadow: 0 1px 2px rgba(0,0,0,0.2);
       box-shadow: 0 1px 2px rgba(0,0,0,0.2);
       color: #fff;
       margin-right: 5px;
    }

    span.deprecated {
        display: inline-block;
        line-height: 2em;
        font-size: 0.8em;
        position: relative;
        padding: 0 10px 0 12px;
        background: #b31d28;
        -webkit-border-bottom-right-radius: 3px;
        border-bottom-right-radius: 3px;
        -webkit-border-top-right-radius: 3px;
        border-top-right-radius: 3px;
        -webkit-border-bottom-left-radius: 3px;
        border-bottom-left-radius: 3px;
        -webkit-border-top-left-radius: 3px;
        border-top-left-radius: 3px;
        -webkit-box-shadow: 0 1px 2px rgba(0,0,0,0.2);
        box-shadow: 0 1px 2px rgba(0,0,0,0.2);
        color: #fff;
    }

    .cardbox {
      overflow: hidden;
      border: 1px solid #676869;
      transition: 0.25s ease box-shadow, 0.25s ease transform;
      max-width: 48%!important;
      min-width: 48%!important;
      min-height: 215px;
      position: relative;
      margin-bottom: 20px;
      background-color: #232529;
    }

    .cardbox:hover {
      box-shadow: 0px 5px 10px rgba(0,0,0,0.3);
      transform: scale(0.996);
    }

    .cardbody {
      padding: 1.75rem!important;
      /*height: 100%!important; */
      display: flex!important;
    }

    .card, .cardbody {
      color: #a3a3a6;
      background-color: #232529;
    }

    .card-iconbox  {
      height: 70px;
      min-width: 70px;
      width: 70px;
      margin-bottom: 0!important;
      margin-top: 0!important;
    }

    .chart-item-logo {
      background-color: transparent!important;
    }

    .chart-info {
      background-color: #2c2e31;
      width: 600px;
      min-width: 0;
      height: 85px;
      margin-left: 0.75rem;
      padding: 0.6rem 1rem;
      flex-direction: column!important;
    }

    .chart-maintainer {
      margin-top: -1px;
      font-size: 0.85rem;
    }

    .chart-maintainer-icon {
      color: #cbd3da!important;
      font-size: .85rem;
      margin-right: 0.25rem!important;
      position: relative!important;
    }

    .align-items-center {
      align-items: center!important;
    }
    .justify-content-center {
      justify-content: center!important;
    }
    .position-relative {
      position: relative!important;
    }
    .d-flex {
      display: flex!important;
    }
    .overflow-hidden {
      overflow: hidden!important;
    }

    .justify-content-between {
      justify-content: space-between!important;
    }

    .justify-content-evenly {
        justify-content: space-evenly!important;
      }

    .mwidth-100 {
      min-width: 0;
    }
    .align-items-stretch {
      align-items: stretch!important;
    }
    .flex-grow-1 {
      flex-grow: 1!important;
    }
    .h-100 {
      height: 100%!important;
    }

    .chart-title {
      color: #a3a3a6;
    }
    .mb-0 {
      margin-bottom: 0!important;
    }
    .text-truncate {
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    .text-descr {
      overflow: hidden;
    }

    .flex-row {
      flex-direction: row!important;
    }

    .title {
      font-size: 1.1rem;
    }

    .mw-100 {
      max-width: 100%!important;
    }

    .chart-title-right {
      padding-left: 2.25rem;
    }
 
    .ms-auto {
      margin-left: auto!important;
    }
    .mb-auto {
      margin-bottom: auto!important;
    }
    .align-items-end {
      align-items: flex-end!important;
    }
    .flex-wrap{
        flex-wrap: wrap!important;
      }
    .flex-column {
      flex-direction: column!important;
    }

    .mt-1 {
      margin-top: 0.25rem!important;
    }

    .additional-info {
      font-size: 75%;
    }

    .download-button{
      color: #cbd3da!important;
      background-color: #232529!important;
      position: relative;
      top: -1px;
      font-size: 75%;
      height: 19px;
      text-align: center;
      text-decoration: none;
      cursor: pointer;
      outline: none;
      border: solid 1px #737475;
    }

    .ms-1 {
      margin-left: 0.25rem!important;
    }

    .download-icon {
      bottom: -1px;
    }

    .download-link:hover, .source-link:hover {
      text-decoration: none!important;
      color: #cbd3da!important;
    }

    .mt-3 {
      margin-top: 1rem!important;
    }

    .pt-md-2 {
      padding-top: 0.5rem!important;
    }
    .mb-md-1 {
      margin-bottom: 0.25rem!important;
    }

    .description {
      color: #a0a0a0!important;
      font-size: .85rem;
    }

    .mt-md-1rem {
      margin-top: 1rem!important;
    }
    .pt-sm-2 {
      padding-top: 0.5rem!important;
    }

    .source {
      margin-right: 7px;
    }

    .markdown-body * {
      box-sizing: unset;
    }

    @media (max-width: 390px) {
        .chart-info {
            background-color: #2c2e31;
            padding: 0.6rem 1rem;
            width: unset!important;
            flex-direction: column!important;
            box-sizing: inherit;
          }
          .cardbox {
            overflow: hidden;
            border: 1px solid #676869;
            transition: 0.25s ease box-shadow, 0.25s ease transform;
            max-width: 100%!important;
            min-height: 215px;
            position: relative;
            margin-bottom: 20px;
            background-color: #232529;
          }
          .cardbody-inner {
            display: unset!important;
          }
          .title {
            font-size: 0.95rem;
            display: unset!important;
          }
          .hide{
            display: none!important;
          }
          .chart-title {
            box-sizing: initial;
          }
          .download-button{
            margin-top: 0.25rem!important;
          }
      }
    </style>
  </head>

  <body class="body">

    <section class="markdown-body">

      <h1>Helm Charts</h1>

      <div>
        <p>
          Welcome to my Helm Repository. I am using these Charts as a central storage for my GitOps approach. <br />
          Whenever I spin up a new cluster, these Charts help me to configure it. <br />
          
          The Charts are mainly used by <a href="https://github.com/tjungbauer/openshift-clusterconfig-gitops">https://github.com/tjungbauer/openshift-clusterconfig-gitops</a><br /><br />

          For further information and some examples, please check the blog: <a href="https://blog.stderr.at/gitopscollection/">https://blog.stderr.at/gitopscollection</a>

          <br /><br />
          Feel free to test them and let me know if there are any issues.
       </p>
      </div>

    <div class="d-flex flex-wrap justify-content-between">
      {{ range $key, $chartEntry := .Entries }}
      <!-- chart box -->
      <div class="cardbox">
        <div class="cardbody flex-column">
          <div class="cardbody-inner d-flex mwidth-100 align-items-stretch flex-grow-1 h-100">

            <!-- Chart title box -->
            <!-- Chart icon -->
            <div class="card-iconbox align-items-center justify-content-center position-relative d-flex overflow-hidden">
              <img class="chart-item-logo" alt="logo" src="{{ (index $chartEntry 0).Icon }}">
            </div>

            <!-- Chart title -->
            <div class="chart-info justify-content-between d-flex">
              <div class="chart-tile mb-0 text-truncate">
                <div class="d-flex align-items-center flex-row justify-content-between title">
                  {{ (index $chartEntry 0).Name }}
                </div>
              </div>

                <div></div>
                {{if not (index $chartEntry 0).Deprecated }}
                <div>
                <div class="mw-100 d-flex flex-row">
                  <div class="chart-maintainer d-flex flex-row">
                    <div class="chart-maintainer-icon">
                      <svg xmlns="http://www.w3.org/2000/svg" height="0.85rem" viewBox="0 0 448 512"><style>svg{fill:#cbd3da}</style><path d="M224 256A128 128 0 1 0 224 0a128 128 0 1 0 0 256zm-45.7 48C79.8 304 0 383.8 0 482.3C0 498.7 13.3 512 29.7 512H418.3c16.4 0 29.7-13.3 29.7-29.7C448 383.8 368.2 304 269.7 304H178.3z"/></svg>
                    </div>
                    <div class="text-truncate">
                      Maintainers:
                      {{ range $maintainers, $maintainers_val := (index $chartEntry 0).Maintainers }}
                      {{ (index $maintainers_val.Name ) }}
                      {{end}}
                    </div>
                  </div>
                </div>
                </div>
                {{else}}
                <div>
                <span class="deprecated">DEPRECATED</span>
                </div>
                {{end}}
            </div>
            <!-- End Chart title box -->

            <!-- Chart Right box -->
            <div class="chart-title-right ms-auto mb-auto align-items-end flex-column d-flex">
           
              <div class="d-flex justify-content-between">
                {{if not (index $chartEntry 0).Deprecated }}
                <div class="source">
                <button class="download-button">
                  <div class="d-flex flex-row align-items-center">
                    <div class="position-relative download-icon">
                      <span class="fa-brands fa-github githublogo"></span>
                    </div>
                    <div class="ms-1"> 
                      <a class="source-link" href="{{ (index $chartEntry 0).Home }}" title="{{ (index $chartEntry 0).Home }}" target="_blank" rel="noopener noreferrer">Source</a>
                    </div>
                  </div>
                </button>
                </div>
                {{end}}

                <div class="">
                <button class="download-button hide">
                  <div class="d-flex flex-row align-items-center">
                    <div class="position-relative download-icon">
                      <svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 384 512"><!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. --><style>svg{fill:#cbd3da}</style><path d="M169.4 470.6c12.5 12.5 32.8 12.5 45.3 0l160-160c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L224 370.8 224 64c0-17.7-14.3-32-32-32s-32 14.3-32 32l0 306.7L54.6 265.4c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3l160 160z"/></svg>
                    </div>
                    <div class="ms-1"> 
                      <a class="download-link" href="{{ (index (index $chartEntry 0).Urls 0) }}" title="{{ (index (index $chartEntry 0).Urls 0) }}">Download</a>
                    </div>
                  </div>
                </button>
                </div>
              </div>



              <div clas="mt-1">
                <small class="additional-info">
                  Last update: {{ (index $chartEntry 0).Created.Format "2006-01-02" }}
                </small>
              </div>
              <div class="mt-1">
                <small class="additional-info">
                  <a class="download-link" href="https://artifacthub.io/packages/helm/openshift-bootstraps/{{ (index $chartEntry 0).Name }}" target="_blank" rel="noopener noreferrer">Artifacthub</a>
                </small>
              </div>

              <div class="mt-1">
                <small class="additional-info">
                  Version: {{ (index $chartEntry 0).Version }}
                </small>
              </div>


            </div>
            <!-- End Chart Right box -->
          </div>



         <!-- Chart description -->
        <div class="mb-0 mt-3 text-descr pt-md-2 mb-md-1 description">
          {{ (index $chartEntry 0).Description }}
        </div>
         <!-- End Chart description -->

        <!-- Chart Tags -->
        {{if not (index $chartEntry 0).Deprecated }}
        <div class="d-flex flex-row justify-content-between mt-md-1rem pt-sm-2">

          <div class="">
            <p class="tags">
              Tags: 
              {{ range $key, $keywords := (index $chartEntry 0).Keywords }}
              <span class="tags">{{ (index $keywords ) }}</span>
              {{end}}
            </p>
          </div>

        </div>
        {{end}}
        <!-- End Chart Tags -->


        </div>
      </div>
      {{end}}

    </div>


      <h2>Usage</h2>
      <pre lang="no-highlight"><code>
        helm repo add tjungbauer https://charts.stderr.at/

        helm repo update
      </code></pre>


      <p>These Charts are used to make my life easier when I need to install a Demo-Environment. Anyone is free to use them and make suggestions.<br />
      Mainly used by: <a href="https://github.com/tjungbauer/openshift-clusterconfig-gitops">https://github.com/tjungbauer/openshift-clusterconfig-gitops</a>
      </p>


<h2>License</h2>
<p>Copyright (c) 2022 Thomas Jungbauer</p>

<p>Licensed under the Apache License, Version 2.0 (the "License");<br />
you may not use this file except in compliance with the License.<br />
You may obtain a copy of the License at<br />
</p>
<pre><code>    <a href="http://www.apache.org/licenses/LICENSE-2.0">http://www.apache.org/licenses/LICENSE-2.0</a> </pre></code>


<p>
Unless required by applicable law or agreed to in writing, software<br />
distributed under the License is distributed on an "AS IS" BASIS,<br />
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.<br />
See the License for the specific language governing permissions and<br />
limitations under the License.<br />
</p>
    </section>
    <time class="time" datetime="{{ .Generated.Format "2006-01-02T15:04:05" }}" pubdate id="generated">{{ .Generated.Format "Mon Jan 2 2006 03:04:05PM MST-07:00" }}</time>
  </body>
</html>
