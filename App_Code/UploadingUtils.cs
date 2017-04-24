using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Caching;
using System.Web.Configuration;

/// <summary>
/// Descripción breve de UploadingUtils
/// </summary>
public static class UploadingUtils
{
    const string DropboxAccessTokenValueSettingName = "UploadDropboxAccessTokenValue";
    const string AzureAccessKeySettingName = "UploadAzureAccessKey";
    const string AmazonAccessKeyIDSettingName = "UploadAmazonAccessKeyID";
    const string AmazonSecretAccessKeySettingName = "UploadAmazonSecretAccessKey";

    const string RemoveTaskKeyPrefix = "DXRemoveTask_";

    public static string GetAmazonAccessKeyID()
    {
        return WebConfigurationManager.AppSettings[AmazonAccessKeyIDSettingName];
    }
    public static string GetAmazonSecretAccessKey()
    {
        return WebConfigurationManager.AppSettings[AmazonSecretAccessKeySettingName];
    }
    public static string GetAzureStorageAccountName()
    {
        return "aspxdemos";
    }
    public static string GetAzureAccessKey()
    {
        return WebConfigurationManager.AppSettings[AzureAccessKeySettingName];
    }
    public static string GetDropboxAccessTokenValue()
    {
        return WebConfigurationManager.AppSettings[DropboxAccessTokenValueSettingName];
    }

    public static void RemoveFileWithDelay(string key, string fullPath, int delay)
    {
        RemoveFileWithDelayInternal(key, fullPath, delay, FileSystemRemoveAction);
    }
    public static void RemoveFileFromAzureWithDelay(string fileKeyName, string accountName, string containerName, int delay)
    {
        AzureFileInfo azureFile = new AzureFileInfo(fileKeyName, accountName, containerName);
        RemoveFileWithDelayInternal(fileKeyName, azureFile, delay, AzureStorageRemoveAction);
    }
    public static void RemoveFileFromAmazonWithDelay(string fileKeyName, string accountName, string bucketName, string region, int delay)
    {
        AmazonFileInfo amazonFile = new AmazonFileInfo(fileKeyName, accountName, bucketName, region);
        RemoveFileWithDelayInternal(fileKeyName, amazonFile, delay, AmazonStorageRemoveAction);
    }
    public static void RemoveFileFromDropboxWithDelay(string fileKeyName, string accountName, int delay)
    {
        DropboxFileInfo dropboxFile = new DropboxFileInfo(fileKeyName, accountName);
        RemoveFileWithDelayInternal(fileKeyName, dropboxFile, delay, DropboxStorageRemoveAction);
    }
    static void FileSystemRemoveAction(string key, object value, CacheItemRemovedReason reason)
    {
        string fileFullPath = value.ToString();
        if (File.Exists(fileFullPath))
            File.Delete(fileFullPath);
    }
    static void AzureStorageRemoveAction(string key, object value, CacheItemRemovedReason reason)
    {
        AzureFileInfo azureFile = value as AzureFileInfo;
        if (azureFile != null)
        {
            AzureFileSystemProvider provider = new AzureFileSystemProvider("");
            provider.AccountName = azureFile.AccountName;
            provider.ContainerName = azureFile.ContainerName;
            FileManagerFile file = new FileManagerFile(provider, azureFile.FileKeyName);
            provider.DeleteFile(file);
        }
    }
    static void AmazonStorageRemoveAction(string key, object value, CacheItemRemovedReason reason)
    {
        AmazonFileInfo amazonFile = value as AmazonFileInfo;
        if (amazonFile != null)
        {
            AmazonFileSystemProvider provider = new AmazonFileSystemProvider("");
            provider.AccountName = amazonFile.AccountName;
            provider.BucketName = amazonFile.BucketName;
            provider.Region = amazonFile.Region;
            FileManagerFile file = new FileManagerFile(provider, amazonFile.FileKeyName);
            provider.DeleteFile(file);
        }
    }
    static void DropboxStorageRemoveAction(string key, object value, CacheItemRemovedReason reason)
    {
        DropboxFileInfo dropboxFile = value as DropboxFileInfo;
        if (dropboxFile != null)
        {
            DropboxFileSystemProvider provider = new DropboxFileSystemProvider("");
            provider.AccountName = dropboxFile.AccountName;
            FileManagerFile file = new FileManagerFile(provider, dropboxFile.FileKeyName);
            provider.DeleteFile(file);
        }
    }
    static void RemoveFileWithDelayInternal(string fileKey, object fileData, int delay, CacheItemRemovedCallback removeAction)
    {
        string key = RemoveTaskKeyPrefix + fileKey;
        if (HttpRuntime.Cache[key] == null)
        {
            DateTime absoluteExpiration = DateTime.UtcNow.Add(new TimeSpan(0, delay, 0));
            HttpRuntime.Cache.Insert(key, fileData, null, absoluteExpiration,
                Cache.NoSlidingExpiration, CacheItemPriority.NotRemovable, removeAction);
        }
    }

    class AzureFileInfo
    {
        public string FileKeyName { get; set; }
        public string AccountName { get; set; }
        public string ContainerName { get; set; }

        public AzureFileInfo(string fileKeyName, string accountName, string containerName)
        {
            FileKeyName = fileKeyName;
            AccountName = accountName;
            ContainerName = containerName;
        }
    }

    class AmazonFileInfo
    {
        public string FileKeyName { get; set; }
        public string AccountName { get; set; }
        public string BucketName { get; set; }
        public string Region { get; set; }

        public AmazonFileInfo(string fileKeyName, string accountName, string bucketName, string region)
        {
            FileKeyName = fileKeyName;
            AccountName = accountName;
            BucketName = bucketName;
            Region = region;
        }
    }
    class DropboxFileInfo
    {
        public string FileKeyName { get; set; }
        public string AccountName { get; set; }

        public DropboxFileInfo(string fileKeyName, string accountName)
        {
            FileKeyName = fileKeyName;
            AccountName = accountName;
        }
    }
}