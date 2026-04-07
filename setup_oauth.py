#!/usr/bin/env python3
"""
Virtual Employee - One-Time Gmail OAuth Setup
=============================================
Run this script ONCE to authorize the virtual employee's Gmail account.

BEFORE running this script, make sure you have an SSH tunnel open:
  In a separate terminal:
  gcloud compute ssh virtual-employee --zone=us-central1-a --ssh-flag="-L 8080:localhost:8080"

Then run this script in your normal SSH session.
"""

import os
import sys

try:
    from google_auth_oauthlib.flow import InstalledAppFlow
    from google.oauth2.credentials import Credentials
    from google.auth.transport.requests import Request
except ImportError:
    print("ERROR: Google auth libraries not installed.")
    print("Run: pip3 install --user google-auth google-auth-oauthlib google-auth-httplib2 google-api-python-client")
    sys.exit(1)

SCOPES = [
    'https://www.googleapis.com/auth/gmail.modify',
    'https://www.googleapis.com/auth/calendar',
    'https://www.googleapis.com/auth/drive.file',
]

BASE_DIR         = os.path.expanduser('~/virtual-employee')
CREDENTIALS_FILE = os.path.join(BASE_DIR, 'credentials.json')
TOKEN_FILE       = os.path.join(BASE_DIR, 'token.json')


def main():
    print()
    print("=" * 60)
    print("  Virtual Employee - Gmail OAuth Setup")
    print("=" * 60)
    print()

    if not os.path.exists(CREDENTIALS_FILE):
        print(f"ERROR: credentials.json not found at {CREDENTIALS_FILE}")
        print("Please upload your OAuth credentials file from GCP first.")
        sys.exit(1)

    # Check if already authenticated
    if os.path.exists(TOKEN_FILE):
        print("Found existing token.json — checking if it's still valid...")
        creds = Credentials.from_authorized_user_file(TOKEN_FILE, SCOPES)
        if creds.valid:
            print("✓ Credentials are valid! No need to re-authenticate.")
            return
        elif creds.expired and creds.refresh_token:
            print("Refreshing expired credentials...")
            creds.refresh(Request())
            with open(TOKEN_FILE, 'w') as f:
                f.write(creds.to_json())
            print("✓ Credentials refreshed successfully!")
            return

    print("Starting OAuth authorization flow...")
    print()
    print("─" * 60)
    print("IMPORTANT: You need the SSH tunnel running in another terminal.")
    print()
    print("If you haven't opened it yet, open a new terminal and run:")
    print("  gcloud compute ssh virtual-employee --zone=us-central1-a --ssh-flag=\"-L 8080:localhost:8080\"")
    print()
    input("Press Enter when the tunnel is ready...")
    print()
    print("A browser window will open. Sign in as: phelixbeeblebrox@gmail.com")
    print()

    flow = InstalledAppFlow.from_client_secrets_file(CREDENTIALS_FILE, SCOPES)

    creds = flow.run_local_server(
        port=8080,
        prompt='consent',
        access_type='offline',
        open_browser=False,   # Print the URL instead of auto-opening (SSH session)
    )

    os.makedirs(BASE_DIR, exist_ok=True)
    with open(TOKEN_FILE, 'w') as f:
        f.write(creds.to_json())

    print()
    print("=" * 60)
    print("  ✓ SUCCESS! OAuth setup complete.")
    print("=" * 60)
    print()
    print(f"Credentials saved to: {TOKEN_FILE}")
    print()
    print("Phelix (phelixbeeblebrox@gmail.com) is now authorized.")
    print("Next: set up the systemd service to start monitoring emails!")


if __name__ == '__main__':
    main()
