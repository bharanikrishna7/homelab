# Vaultwarden
<img src="icon.png" alt="icon" width="100" />

[Documentation](https://github.com/dani-garcia/vaultwarden)

## OIDC SSO Cofiguration
It is necessary that your OIDC/Oauth2 provider responds `TRUE` for claim __`email_verified`__. 

If this is returned as false, Vaultwarden will not create user. Vaultwarden uses email address as username - hence it needs to be sure email address is verified.

### Authentik Configuration
#### Overview
In Authentik we will have to create and application as usual. But we need to make some minor modifications, for SSO to work with Vaultwarden. 

This is because by default claim for __`email_verified`__ is returned as `FALSE`.

#### Create Vaultwarden Application + Provider
* Create New Application for Vaultwarden with Oauth2/OpenID provider


#### Create Property Mapping
We will have to create property mapping for scope email. It should be as shown below:

* name : authentik verified OAuth Mapping: OpenID 'email'
* scope name : email
* description : Email address claim verified is always true
* expression : 
```json
return {
  "email": request.user.email,
  "email_verified": True
}
```

#### Update VaultWarden Provider
* Navigate to Vaultwarden application provider and edit it
* Update Scopes under Advance protocol settings
  * remove scope - authentik default OAuth Mapping: OpenID 'email'
  * add scope - authentik verified OAuth Mapping: OpenID 'email'
  * add scope - authentik default OAuth Mapping: OpenID 'offline_access'

__Authentik is now configured to work with Vaultwarden.__
