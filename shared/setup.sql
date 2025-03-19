CREATE EXTENSION IF NOT EXISTS ltree;
CREATE EXTENSION IF NOT EXISTS "steampipe_postgres_gcp";
CREATE SERVER "steampipe_gcp_sevakamiye" FOREIGN DATA WRAPPER "steampipe_postgres_gcp" OPTIONS (
  config '{
		"project": "aaaaaaaaaaaaaaaaaaa",
		"credentials": \{
      "type": "service_account",
      "project_id": "aaaaaaaaaaaaaaaaaaa",
      "private_key_id": "aaaaaaaaaaaaaaaaaaa",
      "private_key": "-----BEGIN PRIVATE KEY-----\naaaaaaaaaaaaaaaaaaaaaaa\naaaaaaaaaaaaaaaaaaa\naaaaaaaaaaaaaaaaaaaa\n-----END PRIVATE KEY-----\n",
      "client_email": "aaaaaaaaaaaaaaaaaaa@aaaaaaaaaaaaaaaaaaa.iam.gserviceaccount.com",
      "client_id": "aaaaaaaaaaaaaaaaaaa",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/cloudspot-audit%40test-dev-project-415510.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    \}
  }'
);
CREATE SCHEMA IF NOT EXISTS "gcp_sevakamiye";
IMPORT FOREIGN SCHEMA "gcp_sevakamiye" FROM SERVER "steampipe_gcp_sevakamiye" INTO "gcp_sevakamiye";
