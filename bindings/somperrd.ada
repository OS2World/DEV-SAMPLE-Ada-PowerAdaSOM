
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:49 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMPError IS


   sompException : EXCEPTION;

   TYPE sompException_members IS 
   --NEW Corba.IDL_exception_members WITH
   RECORD
      primary : Corba.Long;
        
        -- See below for primary error values
      secondary : Corba.Long;
        
        -- primary=1, see errno.h
   END RECORD;
   PRAGMA Preserve_Layout( sompException_members );

-- FUNCTION get_members (
--    x      : IN Ada.Exceptions.Exception_Occurrence)
--    RETURN      sompException_members;
     
     -- primary=2, see below...
     --
     --Primary Error Codes.

   SOMPERROR_SYSTEM_ERROR : CONSTANT Corba.Long := 1;
     
     -- Errors reported by the system
     -- See errno.h for secondary value

   SOMPERROR_FRAMEWORK_ERROR : CONSTANT Corba.Long := 2;
     
     -- Framework specific error.
     -- See below for secondary value
     --
     --   Secondary Error Codes.

   SR_BASE : CONSTANT Corba.Long := 10;

   SOMPERROR_OBJ_ALREADY_REGISTERED : CONSTANT Corba.Long := 10;
     
     --
     --   Attempt to register an object that was already registered.
     --   This is an internal error and should not be user visible.

   SOMPERROR_COULD_NOT_FIND_DIR : CONSTANT Corba.Long := 11;
     
     --
     --   The system ID assigner attempted to use the path specified in
     --   the environment variable SOMP_PERSIST to find the file containing
     --   the last assigned ID, and the path did not exist.  Check the value
     --   of SOMP_PERSIST and make sure it points to a valid pathname.

   SOMPERROR_IOGROUP_EMPTY : CONSTANT Corba.Long := 12;
     
     --
     --   One of the IO Group Managers was asked to write an empty IOGroup.
     --   This is an internal error and should not be user visible.

   SOMPERROR_COULD_NOT_RESTORE_OBJ : CONSTANT Corba.Long := 13;
     
     --
     --   A request was made to restore an object.  The ID indicated
     --   a valid file, but the requested object was not in the file.

   SOMPERROR_OBJ_IS_NOT_PERSISTENT : CONSTANT Corba.Long := 14;
     
     --
     --   Attempted to store an object that is not derived from PersistentObject.
     --   Only objects derived from PersistentObject can be stored.

   SOMPERROR_IOGROUP_NEWOBJ : CONSTANT Corba.Long := 15;
     
     --
     --   Attempted to restore object, but the appropriate class object
     --   could not be found. Users with SOMPERROR_IOGROUP_NEWOBJ errors
     --   should put their object in a dynamically loadable file or use
     --   their "<className>NewClass" function to create their class object
     --   before attempt to restore objects.
     --
     --   If the objects are already in a DLL, ensure that:
     --   - The SOMInitModule function for the DLL executes the
     --     <className>NewClass function for the class which can not
     --     be restored.
     --   - On OS/2, ensure that the SOMInitModule entry point uses
     --     the "system" linkage convention. (see samples)
     --   - The class definiation in question has the "dllname" modifier.
     --     For example, if your dll was named foo.dll you should have
     --     dllname="foo.dll"; in your .idl file.
     --   - That you have updated the interface repository for your class.
     --     Assuming foo.idl, you can run "sc -sir -u foo.idl" to update
     --     the IR.
     --   - Ensure environment variable SOMIR points to the correct IR
     --     file.
     --
     --   When all else fails, explicitly call the <className>NewClass
     --   function of your class before attempting to restore it.
     --

   SOMPERROR_IOGROUP_NOTREAD : CONSTANT Corba.Long := 16;
     
     --
     --   Attempted to read an object whose I/O Group has never been
     --   read.  This is an internal error, and should not be user
     --   visible.

   SOMPERROR_OBJ_IS_NOT_INITIALIZED : CONSTANT Corba.Long := 17;
     
     --
     --   Attempted to store an object which was not properly initialized.
     --   Code needs to initialize a persistent object with a PersistentID
     --   before saving.
     --
     --   Ensure that you have done one of :
     --   - sompInitGivenId
     --   - sompInitNextAvail
     --   - sompInitNearObject
     --   on the persistent object.
     --

   SOMPERROR_PFW_INIT_FAILED : CONSTANT Corba.Long := 18;
     
     --
     --   Failure to instantiate either the PersistentStorageMgr or
     --   the NameSpaceMgr.  This is an internal error, and should not
     --   be user visible.

   SOMPERROR_ED_INVALID_DATA_TYPE : CONSTANT Corba.Long := 19;
     
     --
     --   Default Encoder/Decoder attempted to read in some data, but
     --   could not recognize the data type.  This could indicate a
     --   corrupted data file or an internal error.

   SOMPERROR_BAD_OBJECT_ID_STRING : CONSTANT Corba.Long := 20;
     
     --
     --   You have attempted to initialize a persistent ID with a
     --   string that is not of the appropriate syntax.
     --
     --   The correct form of a persistent ID is:
     --
     --     <IOGroupMgrClassName>:<IOGroupName>:<GroupKey>
     --
     --    where:
     --
     --      <IOGroupMgrClassName> is the class name of an IO Group Manager
     --      class. The framework supplies two: SOMPAscii and SOMPBinary
     --
     --      <IOGroupName> is a name understandable to the IOGroupMgrClass.
     --      SOMPAscii and SOMPBinary expect this name to be a file name.
     --
     --      <GroupKey> is a key number
     --
     --   If this error occurs during restore, either the ID you have
     --   passed to the Persistent Storage Mgr is incorrect, or possibly
     --   the ID of an object embedded in the object you are attempting
     --   to restore is incorrect. The string ID read from storage may
     --   have been corrupted on disk.

   SOMPERROR_INVALID_OBJECT_TYPE : CONSTANT Corba.Long := 21;
     
     --
     --   One of the media interfaces attempted to determine the type
     --   of an object and couldn't.  This could indicate a corrupted
     --   data file or an internal error.

   SOMPERROR_ENC_DEC_NOT_FOUND : CONSTANT Corba.Long := 22;
     
     --
     --   The class object of the encoder/decoder you are attempting to
     --   use can not be found.  To determine what class the framework
     --   is attempting to find you can invoke the method
     --
     --      sompGetEncoderDecoderName
     --
     --   on the objects of the class you are attempting to save/restore.
     --
     --   This error is typically the result of specifying a user written
     --   encoder/decoder class (via either sompSetEncoderDecoderName
     --   or sompSetClassLevelEncoderDecoderName) without first ensuring
     --   that its class object exists. Execute either the "NewClass"
     --   function of the encoder/decoder class or ensure that it is
     --   installed correctly in a DLL. (see SOMPERROR_IOGROUP_NEWOBJ)
     --
     --   If the the encoder/decoder class name is SOMPAttrEncodeDecoder,
     --   then there is a problem with the framework.
     --

   SOMPERROR_IOGROUP_DOES_NOT_EXIST : CONSTANT Corba.Long := 23;
     
     --
     --   PersistentStorageMgr was trying to read or delete an object, but couldn't
     --   find the IOGroup. For SOMPAscii and SOMPBinary, this means that
     --   the file could not be found.
     --
     --   This error is the result of sompGroupExists method returning FALSE.
     --

   SOMPERROR_OBJECT_NOT_FOUND : CONSTANT Corba.Long := 24;
     
     --
     --   The object could not be restored or deleted because it could
     --   not be found.
     --
     --   Ensure that the SOMP_PERSIST environment variable is set
     --   the same as when you stored the object.
     --
     --   If the file appears to be there but you still can't restore,
     --   perhaps the upper/lower case difference in the name of the file.
     --   The framework is case sensitive.

   SOMPERROR_INTERFACE_NOT_FOUND : CONSTANT Corba.Long := 25;
     
     --
     --   One of the IOGroupManagers was attempting to copy a group
     --   and could not find the appropriate MediaInterface.  This is an
     --   internal error and should not be user visible.

   SOMPERROR_NOT_STORING_OBJECTS : CONSTANT Corba.Long := 26;
     
     --
     --   sompAddObjectToWriteSet has been called but since the
     --   PersistentStorageMgr is not currently storing objects there
     --   is no write set.
     --
     --   The sompAddObjectToWriteSet method is intended to be used
     --   by encoder/decoder objects which are run during a save/restore.

   SOMPERROR_POINTER_NOT_REGISTERED : CONSTANT Corba.Long := 27;
     
     --
     --   Undocumented method was invoked.  This is an internal error,
     --   and should not be user visible.

   SOMPERROR_MEDIA_FORMAT_ERROR : CONSTANT Corba.Long := 28;
     
     --
     --   Attempt was made to read a file with a particular IOGroupMgr,
     --   but the file was incompatible with the requested IOGroupMgr.
     --   Make sure the IOGroupMgr specified in the PersistentID is
     --   compatible with the IOGroupMgr that wrote the file.
     --
     --   This error may also occur if you attempt to restore an object
     --   from a file produced by an aborted store. If the store attempt
     --   failed, the file may have been left in an invalid format.
     --

   SOMPERROR_BAD_IOGROUP_MANAGER : CONSTANT Corba.Long := 29;
     
     --
     --   Attempted to restore an object with a nonexistent IOGroupMgr.
     --   Check the name of the IOGroupMgr in the Persistent ID.
     --
     --   The IOGroupMgr class name is the first part of a peristent ID.
     --   The class object of the IOGroupMgr must exist prior to invoking
     --   store/restore requests to it. Ensure that you have either called
     --   the <className>NewClass procedure of your IOGroupMgr class or
     --   have properly installed your class into a dynamically loadable
     --   library. (see SOMPERROR_IOGROUP_NEWOBJ)

   SOMPERROR_NOT_RESTORING_OBJECTS : CONSTANT Corba.Long := 30;
     
     --
     --   sompAddIdToReadSet has been called but since the
     --   PersistentStorageMgr is not currently restoring objects there
     --   is no read set.
     --
     --   The sompAddIdToReadSet method is intended to be used by encoder/decoder
     --   objects which are run during a save/restore.

   SOMPERROR_ED_AGGREGATE_TYPE_CHG : CONSTANT Corba.Long := 31;
     
     --
     --   An object has been redefined in a way that one of its aggregate
     --   data types is no longer compatible with its stored data.
     --   Typically this means that either
     --   - A new member has been added to a structure.
     --   - A sequence's type has been changed, i.e. what had been a sequence
     --     of reals is now a sequence of strings.
     --   - An array's type has been changed, i.e. what had been an array
     --     of reals is now an array of strings.

   SOMPERROR_ED_ATTR_NOT_DEFINED : CONSTANT Corba.Long := 32;
     
     --
     --   An object has been redefined such that one of its attributes
     --   is no longer valid.
     --
     --   During the restore of an object, data for an nonexistent attribute
     --   was found. The restore has been aborted.

   SOMPERROR_ED_TC_RESTORE_FAILED : CONSTANT Corba.Long := 33;
     
     --
     --   An attempt to read a type code failed.  This could indicate
     --   corrupted data file or an internal error.

   SOMPERROR_ED_TYPECHG : CONSTANT Corba.Long := 34;
     
     --
     --   The definition for an attribute has changed its type.
     --
     --   During the restore of an object, the data type of an attribute
     --   has been found to be different than stored data type.
     --   The restore has been aborted.

   SOMPERROR_ED_TYPE_SIZE_CHG : CONSTANT Corba.Long := 35;
     
     --
     --   The definition for a sequence has changed such that the amount
     --   of data stored in the sequence exceeds the new maximum.

   SOMPERROR_ED_UNSUPPORTED_TYPE : CONSTANT Corba.Long := 36;
     
     --
     --   Attempted to store a non supported type code.  The type of the
     --   data was not a recognized CORBA data type.

   SOMPERROR_ED_CLASS_NOT_DEFINED : CONSTANT Corba.Long := 37;
     
     --
     --   An attempt was made to read an object that is not registered
     --   in the inteface repository.

   SOMPERROR_DUPLICATE_OBJECT_ID : CONSTANT Corba.Long := 38;
     
     --
     --   Attempted to initialize an object with the same ID as another
     --   object already initialized.
     --
     --   Internal codes - not seen by clients.

   SOMPERROR_TEST_ERROR : CONSTANT Corba.Long := 109;
     
     -- for testing purposes

   SOMPINFO_END_OF_ATTRIBUTES : CONSTANT Corba.Long := 44;
     
     -- defedidl - internal use
     --
     --   Error numbers 1 through 4096 are reserved by the framework.
     --   Error numbers above 4096 are available for use by extensions of the
     --   framework.

   SOMPERROR_MAX : CONSTANT Corba.Long := 4096;

END SOMPError; 



