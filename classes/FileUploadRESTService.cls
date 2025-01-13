/**
 * @description       : 
 * @author            : Ritesh Kumar
 * @group             : 
 * @last modified on  : 12-16-2024
 * @last modified by  : Ritesh Kumar
 * Modifications Log
 * Ver   Date         Author         Modification
 * 1.0   12-16-2024   Ritesh Kumar   Initial Version
**/
@RestResource(urlMapping='/fileupload/')
global with sharing class FileUploadRESTService {

    @HttpPost
    global static String uploadFile(String recordId, String filename, String fileType, String fileBlob) {

        // Decode the base64-encoded fileBlob to binary
        Blob fileData = EncodingUtil.base64Decode(fileBlob);

        // Check if the file is valid
        if (fileData == null || fileData.size() == 0) {
            throw new CustomException('Invalid file content.');
        }

        // Check if the required parameters are provided
        if (String.isEmpty(recordId) || String.isEmpty(filename) || String.isEmpty(fileType)) {
            throw new CustomException('Missing required parameters.');
        }

        try {
            // Create ContentVersion record for the uploaded file
            ContentVersion cv = new ContentVersion();
            cv.Title = filename;
            cv.PathOnClient = filename;
            cv.VersionData = fileData;
            //cv.FileType = 'application/' + fileType; // e.g., 'application/jpg' or 'application/pdf'
            insert cv;

			ContentVersion[] insertedContent = [select id, ContentDocumentId from ContentVersion WHERE Id =: cv.Id];
            // Create ContentDocumentLink to associate the file with the record (e.g., Account, Contact)
            ContentDocumentLink cdl = new ContentDocumentLink();
            cdl.ContentDocumentId = insertedContent[0].ContentDocumentId;
            cdl.LinkedEntityId = recordId;
            cdl.ShareType = 'V'; // Viewer permissions
            cdl.Visibility = 'AllUsers';
            insert cdl;

            // Return the response with success message
            return JSON.serialize(new Map<String, String>{
                'message' => 'File uploaded successfully. ContentDocument Id: ' + insertedContent[0].ContentDocumentId,
                'statusCode' => '200'
            });
        } catch (Exception e) {
            // Handle any errors and return error message
            throw new CustomException('Error during file upload: ' + e.getMessage());
        }
    }

    // Custom exception class to handle errors
    public class CustomException extends Exception {}
}