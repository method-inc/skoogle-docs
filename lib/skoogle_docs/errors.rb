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
    # find a document based on a Google Drive document ID.
    class DocumentNotFound < SkoogleDocs::Error
    end
  end
end
