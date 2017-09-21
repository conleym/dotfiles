{:user {:plugins [[lein-environ "1.1.0"]
                  [lein-kibit "0.1.5" :exclusions [org.clojure/clojure]]
                  [lein-bikeshed "0.4.1"]
                  [lein-ancient "0.6.10"]
                  [refactor-nrepl "2.4.0-snapshot"]
                  [cider/cider-nrepl "0.15.1-snapshot"]]
        :env {:squggly {:checkers [:eastwood :kibit :typed]}}
        :dependencies [[acyclic/squiggly-clojure "0.1.6"]
                       ^:replace [org.clojure/tools.nrepl "0.2.12"]]}}
