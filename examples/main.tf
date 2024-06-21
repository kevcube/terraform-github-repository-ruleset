module "repository_ruleset" {
  source = "../"

  repository_name = "icecube.dog"
  rulesets = {
    "protect_main" = {
      enforcement = "active"
      rules = {

        ## The below commented options are enterprise-only
        # branch_name_pattern = {
        #   operator = "regex"
        #   pattern  = "^(main|develop)$"
        #   name     = "test1"
        #   negate   = false
        # }
        # commit_author_email_pattern = {
        #   operator = "contains"
        #   pattern  = "@"
        #   name     = "test2"
        #   negate   = false
        # }
        # commit_message_pattern = {
        #   operator = "contains"
        #   pattern  = "hi"
        #   name     = "test3"
        #   negate   = false
        # }
        # commiter_email_pattern = {
        #   operator = "contains"
        #   pattern  = "@"
        #   name     = "test4"
        #   negate   = false
        # }
        creation         = true
        deletion         = true
        non_fast_forward = true
        pull_request = {
          dismiss_stale_reviews_on_push     = true
          require_code_owner_review         = true
          require_last_push_approval        = true
          required_approving_review_count   = 1
          required_review_thread_resolution = false
        }
        # required_deployments = {
        #   required_deployment_environments = ["production"]
        # }
        required_linear_history = true
        required_signatures     = true
        required_status_checks = {
          required_check = [
            {
              context = "lint"
            }
          ]
          strict_required_status_checks_policy = true
        }
        update = true
        update_allows_fetch_and_merge = true
      }
      target = "branch"
      bypass_actors = [{
        actor_id    = 1
        actor_type  = "OrganizationAdmin"
        bypass_mode = "always"
      }]
      conditions = {
        ref_name = {
          exclude = ["refs/heads/feature/*"]
          include = ["~ALL"]
        }
      }
      repository = "icecube.dog"
    }
  }
}
