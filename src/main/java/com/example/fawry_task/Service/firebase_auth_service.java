package com.example.fawry_task.Service;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseToken;
import org.springframework.stereotype.Service;

    @Service
    public class firebase_auth_service {
        public FirebaseToken verifyToken(String idToken) throws Exception {
            return FirebaseAuth.getInstance().verifyIdToken(idToken);
        }
}
