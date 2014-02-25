module KegbotApi
  # Base error of all KegbotApi errors
  class Error < StandardError
  end

  # Raised when a feature isn't implemented
  class NotImplementedError < Error
  end

  # Raises when a specific resource is not found
  class NotFoundError < Error
  end

  # Raised when an input (user or server) isn't appropriate/expected.
  class InvalidInputError < Error
  end
end