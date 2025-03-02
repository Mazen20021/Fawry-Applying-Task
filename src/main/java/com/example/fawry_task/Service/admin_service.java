package com.example.fawry_task.Service;

import com.example.fawry_task.Model.DTO.admin_dto;
import com.example.fawry_task.Model.DTO.user_dto;
import com.google.cloud.firestore.*;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.stereotype.Service;

import java.util.Map;
import java.util.concurrent.ExecutionException;

@Service
public class admin_service implements admin_service_interface {

    @Override
    public boolean is_admin_found(String email, String password) throws ExecutionException, InterruptedException {

        Firestore dbs = FirestoreClient.getFirestore();
        // Query the "auth" collection for the document named "admins"
        DocumentSnapshot adminsDoc = dbs.collection("auth").document("admins").get().get();
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
    public admin_dto get_admin_data(String email) throws ExecutionException, InterruptedException {
        Firestore db = FirestoreClient.getFirestore();
        // Get the "admins" document from the "auth" collection
        DocumentSnapshot adminsDoc = db.collection("auth").document("admins").collection(email).document("data").get().get();
        if (adminsDoc.exists()) {
            // Retrieve all admin users stored as a map
            Map<String, Object> adminsMap = adminsDoc.getData();
            if (adminsMap != null && adminsMap.get("email").equals(email)) {
                // Extract user details as a map
                    // Convert Firestore data to AdminDTO
                    admin_dto adminDTO = new admin_dto();
                    adminDTO.setEmail(email);
                    adminDTO.setPassword(adminsMap.get("password").toString());
                    adminDTO.setName(adminsMap.get("name").toString());
                    return adminDTO;
                }
        }
        return null; // User not found
    }
}
