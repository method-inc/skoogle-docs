module SkoogleDocs
  # Base error class to wrap all SkoogleDocs errors.
  class Error < StandardError
  end

  module Errors
    # Raise this exception when SkoogleDocs receives an ID
    # to retrieve a file from Google Drive and it is not a
    # document mime type.
    class InvalidDocument < SkoogleDocs::Error
    end

    # Raise this exception when SkoogleDocs is not able to
    # find a document based on a Google Drive document ID
    # and returns the HTTP status code 404.
    class DocumentNotFound < SkoogleDocs::Error
    end

    # Raise this exception when the Google Drive credentials
    # have not been defined.
    class BadAuthenticationData < SkoogleDocs::Error
    end

    # Raise this when the Google Drive credentiasl are invalid
    # and it returns the HTTP status code 401.
    class AuthorizationError < SkoogleDocs::Error
    end
  end
end
