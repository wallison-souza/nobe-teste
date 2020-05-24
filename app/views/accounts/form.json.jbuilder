json.html render partial: 'accounts/form', locals: { account: @account }, :handlers => [:erb], :formats => [:html]
json.account @account
