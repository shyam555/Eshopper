Rails.configuration.stripe = {
  :publishable_key => 'pk_test_9DIeSuvHQdh9htwDvEmucgbW',
  :secret_key      => 'sk_test_o7c1ryVv36l58GKEiytq41jz'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]