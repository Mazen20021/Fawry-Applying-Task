package com.example.fawry_task.Service;

import com.example.fawry_task.Model.DTO.admin_dto;
import com.example.fawry_task.Model.DTO.user_dto;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.stereotype.Service;

import java.util.Map;
import java.util.concurrent.ExecutionException;

@Service
public class user_service implements user_service_interface {
    @Override
    public boolean is_user_found(String email, String password) throws ExecutionException, InterruptedException {
        Firestore db = FirestoreClient.getFirestore();
        // Query the "auth" collection for the document named "admins"
        DocumentSnapshot adminsDoc = db.collection("auth").document("users").get().get();
        if (adminsDoc.exists()) {
            // Get the admin users stored as a map
            var admins = adminsDoc.getData();

            if (admins != null && admins.get("email").equals(email)) {
                // Get stored password for the given email
                String storedPassword = (String) admins.get("password");
                // Compare passwords
                return storedPassword.equals(password);
            }
        }
        return false;
    }

    @Override
    public user_dto get_user_data(String email) throws ExecutionException, InterruptedException {
        Firestore db = FirestoreClient.getFirestore();
        // Get the "admins" document from the "auth" collection
        DocumentSnapshot usersDoc = db.collection("auth").document("users").collection(email).document("data").get().get();
        System.out.println(usersDoc);
        if (usersDoc.exists()) {
            // Retrieve all admin users stored as a map
            Map<String, Object> usersMap = usersDoc.getData();
            if (usersMap != null && usersMap.get("email").equals(email)) {
                // Extract user details as a map
                // Convert Firestore data to AdminDTO
                user_dto userDTO = new user_dto();
                userDTO.setEmail(email);
                userDTO.setPassword(usersMap.get("password").toString());
                userDTO.setName(usersMap.get("name").toString());
                return userDTO;
            }

        }
        return null;
    }
}
