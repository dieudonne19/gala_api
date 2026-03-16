# AuthApi

All URIs are relative to _http://localhost:8080_

| Method                                                       | HTTP request           | Description                             |
| ------------------------------------------------------------ | ---------------------- | --------------------------------------- |
| [**signIn**](AuthApi.md#signin)                              | **POST** /auth/sign-in | Login with and existing account         |
| [**signInWithGoogle**](AuthApi.md#signinwithgoogleoperation) | **POST** /auth/google  | Login or register with Google OAuth     |
| [**signUp**](AuthApi.md#signup)                              | **POST** /auth/sign-up | Create new account with basic user role |

## signIn

> SignInResult signIn(credentials)

Login with and existing account

### Example

```ts
import {
  Configuration,
  AuthApi,
} from '';
import type { SignInRequest } from '';

async function example() {
  console.log("🚀 Testing  SDK...");
  const api = new AuthApi();

  const body = {
    // Credentials (optional)
    credentials: ...,
  } satisfies SignInRequest;

  try {
    const data = await api.signIn(body);
    console.log(data);
  } catch (error) {
    console.error(error);
  }
}

// Run the test
example().catch(console.error);
```

### Parameters

| Name            | Type                          | Description | Notes      |
| --------------- | ----------------------------- | ----------- | ---------- |
| **credentials** | [Credentials](Credentials.md) |             | [Optional] |

### Return type

[**SignInResult**](SignInResult.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: `application/json`
- **Accept**: `application/json`

### HTTP response details

| Status code | Description | Response headers |
| ----------- | ----------- | ---------------- |
| **200**     | OK          | -                |

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

## signInWithGoogle

> SignInResult signInWithGoogle(signInWithGoogleRequest)

Login or register with Google OAuth

### Example

```ts
import {
  Configuration,
  AuthApi,
} from '';
import type { SignInWithGoogleOperationRequest } from '';

async function example() {
  console.log("🚀 Testing  SDK...");
  const api = new AuthApi();

  const body = {
    // SignInWithGoogleRequest (optional)
    signInWithGoogleRequest: ...,
  } satisfies SignInWithGoogleOperationRequest;

  try {
    const data = await api.signInWithGoogle(body);
    console.log(data);
  } catch (error) {
    console.error(error);
  }
}

// Run the test
example().catch(console.error);
```

### Parameters

| Name                        | Type                                                  | Description | Notes      |
| --------------------------- | ----------------------------------------------------- | ----------- | ---------- |
| **signInWithGoogleRequest** | [SignInWithGoogleRequest](SignInWithGoogleRequest.md) |             | [Optional] |

### Return type

[**SignInResult**](SignInResult.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: `application/json`
- **Accept**: `application/json`

### HTTP response details

| Status code | Description | Response headers |
| ----------- | ----------- | ---------------- |
| **200**     | OK          | -                |

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

## signUp

> SignUpResult signUp(credentials)

Create new account with basic user role

### Example

```ts
import {
  Configuration,
  AuthApi,
} from '';
import type { SignUpRequest } from '';

async function example() {
  console.log("🚀 Testing  SDK...");
  const api = new AuthApi();

  const body = {
    // Credentials (optional)
    credentials: ...,
  } satisfies SignUpRequest;

  try {
    const data = await api.signUp(body);
    console.log(data);
  } catch (error) {
    console.error(error);
  }
}

// Run the test
example().catch(console.error);
```

### Parameters

| Name            | Type                          | Description | Notes      |
| --------------- | ----------------------------- | ----------- | ---------- |
| **credentials** | [Credentials](Credentials.md) |             | [Optional] |

### Return type

[**SignUpResult**](SignUpResult.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: `application/json`
- **Accept**: `application/json`

### HTTP response details

| Status code | Description | Response headers |
| ----------- | ----------- | ---------------- |
| **200**     | OK          | -                |

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)
