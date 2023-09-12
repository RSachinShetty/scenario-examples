#!/bin/bash

#!/bin/bash

kubectl create secret generic database-data -n database-ns --from-literal=DB_PASSWORD=secret