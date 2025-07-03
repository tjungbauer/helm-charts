<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <title>Helm Charts - stderr.at</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Helm Charts Repository for GitOps cluster configuration and OpenShift management">
    <meta name="theme-color" content="#303030">

    <!-- SEO & Social Media -->
    <meta property="og:title" content="Helm Charts - stderr.at">
    <meta property="og:description" content="Central storage for GitOps Helm charts">
    <meta property="og:type" content="website">

    <!-- Icons -->
    <link rel="icon" type="image/x-icon" href="images/favicon-152.png">
    <link rel="icon" type="image/png" href="images/favicon-152.png">
    <link rel="apple-touch-icon" href="images/favicon-152.png">

    <!-- External CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/2.10.0/github-markdown.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/brands.min.css" integrity="sha512-nS1/hdh2b0U8SeA8tlo7QblY6rY6C+MgkZIeRzJQQvMsFfMQFUKp+cgMN2Uuy+OtbQ4RoLMIlO2iF7bIEY3Oyg==" crossorigin="anonymous" referrerpolicy="no-referrer" />

    <!-- Your custom styles -->
    <link rel="stylesheet" href="css/styles.css">

    <meta http-equiv="Content-Security-Policy" 
          content="default-src 'self'; 
                   style-src 'self' 'unsafe-inline' https://cdnjs.cloudflare.com; 
                   script-src 'self' 'unsafe-inline'; 
                   img-src 'self' data: https:; 
                   font-src 'self' data: https://cdnjs.cloudflare.com;
                   connect-src 'self';">
  </head>

  <body class="body">

    <section class="markdown-body">

      <h1>Helm Charts</h1>

      <div>
        <p>
          Welcome to my Helm Repository! This collection serves as a central storage for my GitOps approach to cluster management. <br />
          Whenever I spin up a new OpenShift cluster, these charts help me configure it quickly and consistently. <br />
          
          The charts are primarily used by my <a href="https://github.com/tjungbauer/openshift-clusterconfig-gitops">OpenShift GitOps cluster configuration project</a>.<br /><br />

          For detailed information and usage examples, please check out my blog: <a href="https://blog.stderr.at/gitopscollection/">GitOps Collection</a>

          <br /><br />
          Feel free to test these charts and let me know if you encounter any issues or have suggestions for improvements.
       </p>
      </div>


    <div class="search-container">
      <label for="chart-search" class="visually-hidden">Search charts</label>
      <input type="search" 
             id="chart-search" 
             placeholder="Search charts by name or tags..." 
             class="search-input">
    </div>

    <div class="chart-stats">
      <p><span id="chart-count">{{ len .Entries }}</span> charts available</p>
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
              <img class="chart-item-logo" 
                   alt="Logo for {{ (index $chartEntry 0).Name }} helm chart" 
                   src="{{ (index $chartEntry 0).Icon }}"
                   loading="lazy"
                   width="70" 
                   height="70">
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
                      <svg xmlns="http://www.w3.org/2000/svg" height="0.85rem" viewBox="0 0 448 512" class="maintainer-icon">
                        <path d="M224 256A128 128 0 1 0 224 0a128 128 0 1 0 0 256zm-45.7 48C79.8 304 0 383.8 0 482.3C0 498.7 13.3 512 29.7 512H418.3c16.4 0 29.7-13.3 29.7-29.7C448 383.8 368.2 304 269.7 304H178.3z"/>
                      </svg>
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
                  <button class="download-button" 
                          onclick="window.open('{{ (index $chartEntry 0).Home }}', '_blank', 'noopener,noreferrer')"
                          title="View source code for {{ (index $chartEntry 0).Name }}"
                          aria-label="View source code for {{ (index $chartEntry 0).Name }}">
                    <div class="d-flex flex-row align-items-center">
                      <div class="position-relative download-icon">
                        <span class="fa-brands fa-github githublogo"></span>
                      </div>
                      <div class="ms-1">Source</div>
                    </div>
                  </button>
                </div>
                {{end}}

                <div class="">
                  <button class="download-button hide" 
                          onclick="window.open('{{ (index (index $chartEntry 0).Urls 0) }}', '_blank')"
                          title="Download {{ (index $chartEntry 0).Name }} version {{ (index $chartEntry 0).Version }}"
                          aria-label="Download {{ (index $chartEntry 0).Name }} version {{ (index $chartEntry 0).Version }}">
                    <div class="d-flex flex-row align-items-center">
                      <div class="position-relative download-icon">
                        <svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 384 512">
                          <style>svg{fill:#cbd3da}</style>
                          <path d="M169.4 470.6c12.5 12.5 32.8 12.5 45.3 0l160-160c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L224 370.8 224 64c0-17.7-14.3-32-32-32s-32 14.3-32 32l0 306.7L54.6 265.4c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3l160 160z"/>
                        </svg>
                      </div>
                      <div class="ms-1">Download</div>
                    </div>
                  </button>
                </div>
              </div>



              <div class="mt-1">
                <small class="additional-info">
                  Last updated: {{ (index $chartEntry 0).Created.Format "2006-01-02" }}
                </small>
              </div>
              <div class="mt-1">
                <small class="additional-info">
                  <a class="download-link" href="https://artifacthub.io/packages/helm/openshift-bootstraps/{{ (index $chartEntry 0).Name }}" target="_blank" rel="noopener noreferrer">ArtifactHub</a>
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


      <h2>Getting Started</h2>
      <p>To use these Helm charts, add this repository to your Helm configuration:</p>
      <pre><code>helm repo add tjungbauer https://charts.stderr.at/
helm repo update</code></pre>

      <p>Then install any chart:</p>
      <pre><code>helm install my-release tjungbauer/&lt;chart-name&gt;</code></pre>


      <p>These Charts are used to make my life easier when I need to install a Demo-Environment. Anyone is free to use them and make suggestions.<br />
      Mainly used by: <a href="https://github.com/tjungbauer/openshift-clusterconfig-gitops">https://github.com/tjungbauer/openshift-clusterconfig-gitops</a>
      </p>


<h2>License</h2>
<p>Copyright (c) 2025 Thomas Jungbauer</p>

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

<h2>Icons</h2>
<a href="https://www.flaticon.com/free-icons/" title="">Various Artists Flaticon</a>

    </section>
    <time class="time" datetime="{{ .Generated.Format "2006-01-02T15:04:05" }}" pubdate id="generated">{{ .Generated.Format "Mon Jan 2 2006 03:04:05PM MST-07:00" }}</time>
    <script>
    document.addEventListener('DOMContentLoaded', function() {
      const searchInput = document.getElementById('chart-search');
      const chartCards = document.querySelectorAll('.cardbox');
      
      if (searchInput) {
        searchInput.addEventListener('input', function(e) {
          const query = e.target.value.toLowerCase();
          
          let visibleCount = 0;
          chartCards.forEach(card => {
            const title = card.querySelector('.title').textContent.toLowerCase();
            const description = card.querySelector('.description').textContent.toLowerCase();
            const tags = Array.from(card.querySelectorAll('span.tags')).map(tag => tag.textContent.toLowerCase());
            
            const matches = title.includes(query) || 
                           description.includes(query) || 
                           tags.some(tag => tag.includes(query));
            
            card.style.display = matches ? 'block' : 'none';
            if (matches) visibleCount++;
          });

          // Update count display
          const countElement = document.getElementById('chart-count');
          if (countElement) {
            countElement.textContent = query ? visibleCount : chartCards.length;
          }
        });
      }

      // NEW: Scroll to top functionality
      const scrollToTopBtn = document.getElementById('scroll-to-top');
      
      if (scrollToTopBtn) {
        // Show/hide button based on scroll position
        window.addEventListener('scroll', function() {
          if (window.pageYOffset > 300) {
            scrollToTopBtn.classList.add('visible');
          } else {
            scrollToTopBtn.classList.remove('visible');
          }
        });

        // Smooth scroll to top when clicked
        scrollToTopBtn.addEventListener('click', function() {
          window.scrollTo({
            top: 0,
            behavior: 'smooth'
          });
        });

        // Also handle keyboard activation
        scrollToTopBtn.addEventListener('keydown', function(e) {
          if (e.key === 'Enter' || e.key === ' ') {
            e.preventDefault();
            window.scrollTo({
              top: 0,
              behavior: 'smooth'
            });
          }
        });
      }
    });
    </script>
    <!-- Scroll to top button -->
    <button id="scroll-to-top" class="scroll-to-top" aria-label="Scroll to top" title="Scroll to top">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <polyline points="18,15 12,9 6,15"></polyline>
      </svg>
    </button>
  </body>
</html>
