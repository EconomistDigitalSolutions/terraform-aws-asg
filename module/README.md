# Considrations

* Launch template vs launch configuration
  * changing the launch configuration leads to terraform errors
  * do launch templates behave differently?
  * if so, consider changing.

* add cloudfront distribution?

* are infrastructure changes reflected?

* are code changes (deployed to ECR) reflected on the environment?

* is it possible to use spot instances to reduce the costs?

* instances are still publicly accessible
  * they should be private
  * possible solution?
    * put instances in "private subnet" (subnet whose route table does not point to IGW)
    * route "private subnet" traffic to "public subnet" (or is it the other way around?)


