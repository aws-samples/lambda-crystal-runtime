require "http/client"

INVOCATION_URL = "http://#{ENV["AWS_LAMBDA_RUNTIME_API"]}/2018-06-01/runtime/invocation"

def lambda_event_loop
  while true
    event =
      HTTP::Client.get("#{INVOCATION_URL}/next")

    raise "unexpected response #{event.status_code}" unless event.status_code == 200

    request_id = event.headers["Lambda-Runtime-Aws-Request-Id"]

    res = yield event.body

    HTTP::Client.post("#{INVOCATION_URL}/#{request_id}/response", body: res, headers: nil)
  end
end
