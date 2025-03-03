package com.example.fawry_task.Service;

import com.example.fawry_task.Constants.db_constants;
import com.example.fawry_task.Model.DTO.user_dto;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.WriteResult;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ExecutionException;

@Service
public class user_service implements user_service_interface {
    db_constants dbConstants = new db_constants();

    @Override
    public boolean is_user_found(String email, String password) throws ExecutionException, InterruptedException {
        Firestore db = FirestoreClient.getFirestore();
        // Query the "auth" collection for the document named "admins"
        DocumentSnapshot usersDoc = db.collection(dbConstants.getMainCollection()).document(dbConstants.getSubUserDocument()).get().get();
        if (usersDoc.exists()) {
            // Get the admin users stored as a map
            var admins = usersDoc.getData();

            if (admins != null && admins.get(dbConstants.getEmailParam()).equals(email)) {
                // Get stored password for the given email
                String storedPassword = (String) admins.get(dbConstants.getPasswordParam());
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
        DocumentSnapshot usersDoc = db.collection(dbConstants.getMainCollection()).document(dbConstants.getSubUserDocument()).collection(email).document(dbConstants.getSubSubDocument()).get().get();
        System.out.println(usersDoc);
        if (usersDoc.exists()) {
            // Retrieve all admin users stored as a map
            Map<String, Object> usersMap = usersDoc.getData();
            if (usersMap != null && usersMap.get(dbConstants.getEmailParam()).equals(email)) {
                // Extract user details as a map
                // Convert Firestore data to AdminDTO
                user_dto userDTO = new user_dto();
                userDTO.setEmail(email);
                userDTO.setPassword(usersMap.get(dbConstants.getPasswordParam()).toString());
                userDTO.setName(usersMap.get(dbConstants.getNameParam()).toString());
                return userDTO;
            }
        }
        return null;
    }

    @Override
    public boolean add_new_user(String email, String password, String name) {
        Firestore db = FirestoreClient.getFirestore();
        DocumentReference userDocRef = db.collection(dbConstants.getMainCollection()).document(dbConstants.getSubUserDocument()).collection(email).document(dbConstants.getSubSubDocument());
        System.out.println(userDocRef);
        try {
            // Check if user exists
            ApiFuture<DocumentSnapshot> future = userDocRef.get();
            DocumentSnapshot document = future.get();

            if (document.exists()) {
                return false;
            }

            HashMap<String, Object> userData = new HashMap<>();
            userData.put("email", email);
            userData.put("password", password); // Consider hashing passwords instead of storing as plain text
            userData.put("name", name);
            userData.put("id" , dbConstants.getId() + 1);
            // Add user to Firestore
            ApiFuture<WriteResult> result = userDocRef.set(userData);
            result.get(); // Ensure the operation completes
            return true;
        } catch (InterruptedException | ExecutionException e) {
            e.printStackTrace();
            return false;
        }
    }
}
