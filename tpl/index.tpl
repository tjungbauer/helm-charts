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

      .snippet { position: relative; }
      .snippet:hover .btn, .snippet .btn:focus {
        opacity: 1;
      }
      .snippet .btn {
        -webkit-transition: opacity .3s ease-in-out;
        -o-transition: opacity .3s ease-in-out;
        transition: opacity .3s ease-in-out;
        opacity: 0;
        padding: 2px 6px;
        position: absolute;
        right: 4px;
        top: 4px;
      }
      .btn {
        position: relative;
        display: inline-block;
        padding: 6px 12px;
        font-size: 13px;
        font-weight: 700;
        line-height: 20px;
        color: #333;
        white-space: nowrap;
        vertical-align: middle;
        cursor: pointer;
        background-color: #eee;
        background-image: linear-gradient(#fcfcfc,#eee);
        border: 1px solid #d5d5d5;
        border-radius: 3px;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
        -webkit-appearance: none;
      }

      .charts {
        display: flex;
        flex-wrap: wrap;
      }

      .chart {
        border-radius: 8px;
        overflow: hidden;
        border: 1px solid #ccc;
        /* transition: transform .2s ease; */
        transition: 0.25s ease box-shadow, 0.25s ease transform;
        /*background-color: #eaedef; */
        width: 300px;
        min-height: 350px;
        margin: 0.5em;
        box-shadow: 3px 2px 8px 10px rgb(0 0 0 / 35%);
        position: relative;
      }

      .chart:hover {
        box-shadow: 0px 5px 10px rgba(0,0,0,0.3);
        transform: scale(0.985);
      }

      .chart .icon {
        display: flex;
        justify-content: center;
        width: 100%;
        height: 110px;
        background-color: #fff;
        align-items: center;
      }
      .chart .icon img {
        max-height: 80%;
      }
      .chart .body {
        position: relative;
        display: flex;
        justify-content: center;
        flex: 1;
        border-top: 1px solid #d7d9dd;
        padding: 0 1em;
        flex-direction: column;
        word-wrap: break-word;
        text-align: center;
      }
      .chart .body .info {
        word-wrap: break-word;
        text-align: center;
      }
      .chart .body .description {
        text-align: left;
      }
      .time {
        color: #dedede;
      }
      .githublogo {
        color: #fff;
        text-align: right;
      }
      .bottom{
        position: relative;
      }

      .bottom span {
        position: absolute;
        bottom: 10px;
        right: 10px;
      }

      div.chart div.bottom {
        position: absolute;
        bottom: 0;
        right: 0;
      }

      div.tags {
        justify-content: center;
        text-align: center;
        display: flex;
      }

      p.tags {
        position: absolute;
        bottom: 0;
      }

      span.tags {
       display: inline-block;
       line-height: 2em;
       font-size: 0.8em;
       position: relative;
       /* margin: 0 16px 8px 0; */
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
    }

    .tagsbottom {
      position: absolute;
      left: 0;
      right: 0;
      /* top: auto; */
      bottom: 0;
      justify-content: center;
      display: flex;
      text-align: center;
    }
    </style>
  </head>

  <body class="body">

    <section class="markdown-body">
      <h1>Helm Charts</h1>

      <h2>Usage</h2>
      <pre lang="no-highlight"><code>
        helm repo add tjungbauer https://charts.stderr.at/

        help repo update
      </code></pre>


      <p>These Charts are used to make my life easier when I need to install a Demo-Environment. Anyone is free to use them and make suggestions.<br />
      Mainly used by: <a href="https://github.com/tjungbauer/openshift-cluster-bootstrap">https://github.com/tjungbauer/openshift-cluster-bootstrap</a>
      </p>

      <h2>Charts</h2>

      <div class="charts">

          {{ range $key, $chartEntry := .Entries }}

          <div class="chart">
            <a href="{{ (index (index $chartEntry 0).Urls 0) }}" title="{{ (index (index $chartEntry 0).Urls 0) }}">
              <div class="icon">
                <img class="chart-item-logo" alt="logo" src="{{ (index $chartEntry 0).Icon }}">
              </div>
              <div class="body">
                <p class="info">
                  {{ (index $chartEntry 0).Name }} ({{ (index $chartEntry 0).Version }})
                  <a href="{{ (index (index $chartEntry 0).Urls 0) }}" title="{{ (index (index $chartEntry 0).Urls 0) }}"></a>
                </p>
                <p class="description">
                  {{ (index $chartEntry 0).Description }}
                </p>
              </div>
            <div class="tagsbottom">
              <p class="tags">
                {{ range $key, $keywords := (index $chartEntry 0).Keywords }}
                <span class="tags">{{ (index $keywords ) }}</span>
                {{end}}
              </p>
            </div>
            <div class="bottom">
                <a href="{{ (index $chartEntry 0).Home }}">
                    <span class="fa-brands fa-github githublogo"></span>
                </a>
            </div>
          </div>
          {{end}}

      </div>

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
