## GI (Github Issues)

This script gets a list of Github issues and orders them by a labels created_at time

#### Installation

    git clone git@github.com:TheJefe/gi.git
    cd gi
    bundle

#### Configure

This script requires a couple of environment variables to work

    export GITHUB_USERNAME=TheJefe
    export GITHUB_TOKEN=1234
    export GI_QUERY="state:open type:pr user:thinkthroughmath label:\"Needs QA\""

##### For OSx

For OSx I find it best to set the above environment variables listed above in `/etc/profile`. That way they aren't likely to get checked into any source control, and they should be available on all of your terminal sessions.

Secondly, it I find that setting the following alias in my `~/.bash_profile` makes it convenient to run.

    alias gi="/git/gi/gi; open issues.html; sleep 2; rm issues.html"

#### Usage

You can run this script with this

    ./gi

You should then have a local file, `issues.html` that you can open in a browser

#### Wrapped in a webserver

see https://github.com/anthlam/gi-web
