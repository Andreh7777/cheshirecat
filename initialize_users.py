import os
import uuid
from cat.db.crud import get_setting_by_name, update_users
from cat.auth.auth_utils import hash_password
from cat.auth.permissions import get_full_permissions

users = get_setting_by_name('users')

if not users:
    print("⚠️ No users configured")
    admin_id = str(uuid.uuid4())
    admin_username = os.getenv("CHESHIRECAT_USERNAME")
    admin_pass = os.getenv("CHESHIRECAT_PASSWORD")

    update_users({
        admin_id: {
            "id": admin_id,
            "username": admin_username,
            "password": hash_password(admin_pass),
            "permissions": get_full_permissions()
        }
    })
    print("✅ Admin users configured 😺")
else:
    print("👥 Users already configured ✅")



