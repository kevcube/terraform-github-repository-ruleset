resource "github_repository_ruleset" "this" {
  for_each = var.rulesets

  name = each.key

  enforcement = each.value.enforcement

  rules {
    dynamic "branch_name_pattern" {
      for_each = { for idx, val in [each.value.rules.branch_name_pattern] : idx => val if val != null }
      content {
        operator = branch_name_pattern.value.operator
        pattern  = branch_name_pattern.value.pattern
        name     = branch_name_pattern.value.name
        negate   = branch_name_pattern.value.negate
      }
    }

    dynamic "commit_author_email_pattern" {
      for_each = { for idx, val in [each.value.rules.commit_author_email_pattern] : idx => val if val != null }
      content {
        operator = commit_author_email_pattern.value.operator
        pattern  = commit_author_email_pattern.value.pattern
        name     = commit_author_email_pattern.value.name
        negate   = commit_author_email_pattern.value.negate
      }
    }

    dynamic "commit_message_pattern" {
      for_each = { for idx, val in [each.value.rules.commit_message_pattern] : idx => val if val != null }
      content {
        operator = commit_message_pattern.value.operator
        pattern  = commit_message_pattern.value.pattern
        name     = commit_message_pattern.value.name
        negate   = commit_message_pattern.value.negate
      }
    }

    dynamic "committer_email_pattern" {
      for_each = { for idx, val in [each.value.rules.committer_email_pattern] : idx => val if val != null }
      content {
        operator = committer_email_pattern.value.operator
        pattern  = committer_email_pattern.value.pattern
        name     = committer_email_pattern.value.name
        negate   = committer_email_pattern.value.negate
      }
    }

    creation         = each.value.rules.creation
    deletion         = each.value.rules.deletion
    non_fast_forward = each.value.rules.non_fast_forward

    dynamic "pull_request" {
      for_each = { for idx, val in [each.value.rules.pull_request] : idx => val if val != null }
      content {
        dismiss_stale_reviews_on_push     = pull_request.value.dismiss_stale_reviews_on_push
        require_code_owner_review         = pull_request.value.require_code_owner_review
        require_last_push_approval        = pull_request.value.require_last_push_approval
        required_approving_review_count   = pull_request.value.required_approving_review_count
        required_review_thread_resolution = pull_request.value.required_review_thread_resolution
      }
    }

    dynamic "required_deployments" {
      for_each = { for idx, val in [each.value.rules.required_deployments] : idx => val if val != null }
      content {
        required_deployment_environments = required_deployments.value.required_deployment_environments
      }
    }

    dynamic "required_status_checks" {
      for_each = { for idx, val in [each.value.rules.required_status_checks] : idx => val if val != null }
      content {
        dynamic "required_check" {
          for_each = { for idx, val in required_status_checks.value.required_check : idx => val if val != null }
          content {
            context        = required_check.value.context
            integration_id = required_check.value.integration_id
          }
        }
      }
    }
  }

  target = each.value.target

  dynamic "bypass_actors" {
    for_each = { for idx, val in each.value.bypass_actors : idx => val if val != null }
    content {
      actor_id    = bypass_actors.value.actor_id
      actor_type  = bypass_actors.value.actor_type
      bypass_mode = bypass_actors.value.bypass_mode
    }
  }

  dynamic "conditions" {
    for_each = { for idx, val in [each.value.conditions] : idx => val if val != null }
    content {
      ref_name {
        exclude = conditions.value.ref_name.exclude
        include = conditions.value.ref_name.include
      }
    }
  }

  repository = var.repository_name
}
