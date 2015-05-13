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

#### Usage

You can run this script with this

    ./gi

You should then have a local file, `issues.html` that you can open in a browser
