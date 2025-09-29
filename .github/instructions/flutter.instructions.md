---
applyTo: '**'
---
# 📱 Flutter Development - Logical Concepts & Principles

## 🎯 **Core Development Philosophy**
- **Clean Architecture**: Separation of concerns through 3-layer architecture (Presentation, Domain, Data)
- **Constructor Dependency Injection**: Use constructor-based DI for better testability and maintainability
- **Single Responsibility Principle**: Each class/controller should have one reason to change
- **State Management Strategy**: Reactive programming with clear state flows
- **Offline-First Approach**: Design for intermittent connectivity scenarios

## 🏗️ **Architectural Constraints**

### Layer Boundaries
- **Domain Layer Independence**: Must not depend on any other layer
- **Data Layer Dependency**: Can only depend on Domain layer
- **Presentation Layer Dependency**: Can only depend on Domain layer (not Data directly)
- **Circular Dependency Prevention**: Never allow reverse dependencies

### State Management Rules
- **Single Source of Truth**: Each piece of data should have one authoritative source
- **Immutable State**: State objects should be immutable to prevent side effects  
- **Reactive Updates**: UI should automatically reflect state changes
- **Error State Handling**: Every loading operation must handle error states
- **Loading State Management**: Use enum-based loading states instead of boolean flags

### Dependency Injection Principles
- **Constructor Injection**: Dependencies must be injected through constructors
- **Interface Segregation**: Depend on abstractions, not concretions
- **Lazy Loading**: Initialize dependencies only when needed
- **Service Locator Avoidance**: Avoid using service locator pattern within business logic

## 📁 **Project Organization Logic**

### Modular Structure Principles
- **Feature-based Organization**: Group related functionality together
- **Layer Separation**: Maintain clear boundaries between architectural layers
- **Shared Resources**: Common utilities and widgets in dedicated shared folders
- **Configuration Centralization**: Environment and app-specific settings in dedicated config areas

### Folder Hierarchy Rules
```
lib/
├── app/                        # Application-wide configuration
│   ├── bindings/               # Dependency injection setup
│   └── routes/                 # Navigation configuration
├── core/                       # Infrastructure & cross-cutting concerns
│   ├── constants/              # Application constants
│   ├── errors/                 # Error handling abstractions
│   ├── network/                # HTTP client configuration
│   └── services/               # Core platform services
├── data/                       # External data sources
│   ├── datasources/            # API & local data access
│   ├── models/                 # Data transfer objects
│   └── repositories/           # Repository implementations
├── domain/                     # Business logic (pure Dart)
│   ├── entities/               # Business objects
│   ├── repositories/           # Repository contracts
│   └── usecases/               # Business operations
└── presentation/               # UI & state management
    ├── controllers/            # State management controllers
    ├── pages/                  # Screen-level components
    └── widgets/                # Reusable UI components
```

### Naming Conventions
- **Files**: snake_case for all file names
- **Classes**: PascalCase with descriptive suffixes (Controller, Service, Repository)
- **Variables**: camelCase with meaningful names
- **Constants**: UPPER_SNAKE_CASE for compile-time constants
- **Private Members**: Prefix with underscore (_privateField)

## 🔧 **Core Development Rules**

### Error Handling Principles
- **Fail Fast**: Catch errors as early as possible in the development cycle
- **Graceful Degradation**: Application should continue functioning when non-critical components fail
- **User-Friendly Messages**: Never expose technical errors directly to end users
- **Comprehensive Logging**: Log all errors with sufficient context for debugging
- **Recovery Strategies**: Implement retry mechanisms for transient failures

### Network Communication Standards
- **Connection Resilience**: Handle intermittent network connectivity gracefully
- **Timeout Configuration**: Set appropriate timeouts for different types of operations
- **Retry Logic**: Implement exponential backoff for failed requests
- **Authentication Flow**: Automatic token refresh and logout on authentication failures
- **Caching Strategy**: Cache responses to enable offline functionality

### Local Storage Guidelines
- **Data Persistence**: Critical data must be persisted locally
- **Storage Security**: Sensitive data must be encrypted
- **Cache Management**: Implement LRU or TTL-based cache eviction
- **Migration Strategy**: Plan for schema changes in local storage
- **Data Synchronization**: Handle conflicts between local and remote data

### Service Architecture Rules
- **Service Independence**: Services should not directly depend on other services
- **Interface Contracts**: Define clear interfaces for all services
- **Lifecycle Management**: Properly initialize and dispose of service resources
- **Configuration Injection**: Services should receive configuration through dependency injection
- **Testing Isolation**: Services must be easily mockable for testing

## 🏛️ **Domain Layer Principles**

### Business Logic Constraints
- **Pure Dart Code**: Domain layer must not depend on Flutter framework
- **Platform Independence**: Business logic should work across any platform
- **Framework Agnostic**: No dependencies on external libraries in entities and use cases
- **Immutable Entities**: Business objects should be immutable value objects
- **Single Responsibility**: Each use case should handle only one business operation

### Repository Pattern Rules
- **Interface-Based**: Always define repository interfaces in domain layer
- **Data Source Abstraction**: Repository abstracts away data source details
- **Consistent Return Types**: Use domain entities, not data models in repository interfaces
- **Error Propagation**: Let domain-level exceptions bubble up appropriately

### Use Case Design Principles
- **One Business Operation**: Each use case handles exactly one business requirement
- **Parameter Validation**: Validate all inputs at the use case level
- **Dependency Inversion**: Use case depends on repository abstraction, not implementation
- **Result Wrapping**: Consider using Result/Either pattern for error handling

## 📊 **Data Layer Guidelines**

### Data Source Management
- **Remote vs Local**: Clear separation between remote API and local database data sources
- **Data Model Mapping**: Convert between data models and domain entities at repository level
- **Caching Strategy**: Implement appropriate caching based on data volatility
- **Synchronization Logic**: Handle data sync between local and remote sources

### Model Design Rules
- **Data Transfer Objects**: Data models are DTOs, not business objects
- **JSON Serialization**: All data models must support JSON serialization/deserialization
- **Null Safety**: Handle nullable fields appropriately from external sources
- **Validation**: Basic data validation before converting to domain entities

---

## 🎮 **Presentation Layer Concepts**

### State Management Philosophy
- **Reactive Programming**: UI automatically reacts to state changes
- **Unidirectional Data Flow**: Data flows down, events flow up
- **Controller Separation**: Business logic separate from UI logic
- **State Encapsulation**: Controllers manage their own state internally
- **Minimal Rebuilds**: Only rebuild widgets when necessary

### Controller Design Principles
- **Single Controller Per Screen**: One main controller per major UI screen
- **Constructor Dependency Injection**: Inject dependencies through constructor
- **Lifecycle Management**: Properly handle controller lifecycle (init, dispose)
- **State Validation**: Validate state changes before updating UI
- **Error Boundary**: Controllers should handle and expose errors appropriately

### UI Component Guidelines
- **Component Composition**: Build complex UI from simple, reusable components
- **Props Down, Events Up**: Pass data down through properties, send events up through callbacks
- **Stateless When Possible**: Prefer stateless widgets for pure UI components
- **Performance Optimization**: Use const constructors and avoid unnecessary rebuilds
- **Accessibility**: Implement proper accessibility features

### Navigation Rules
- **Declarative Routing**: Define routes declaratively, not imperatively
- **Route Guards**: Implement authentication and authorization checks
- **Deep Linking**: Support deep links for better user experience
- **Navigation State**: Maintain navigation state properly
- **Memory Management**: Clean up resources when navigating away

## 🔗 **Integration & Configuration Logic**

### Dependency Binding Strategy
- **Lazy Initialization**: Initialize dependencies only when needed
- **Singleton Management**: Critical services should be singletons
- **Scope Management**: Properly scope dependencies to their required lifetime
- **Testing Flexibility**: Bindings should be easily overrideable for testing

### Route Management Concepts
- **Modular Routing**: Organize routes by feature modules
- **Middleware Pattern**: Use middleware for cross-cutting concerns
- **Parameter Validation**: Validate route parameters at entry points
- **Fallback Handling**: Provide fallback routes for unknown paths

## 🎯 **State Management Patterns**

### Constructor Dependency Injection Pattern
**The Golden Rule**: When dealing with multiple controllers → Use Constructor DI pattern

### Controller Interaction Guidelines
- **Single Main Controller**: One primary controller per screen that orchestrates other dependencies
- **Dependency Delegation**: Main controller receives other controllers through constructor injection
- **Property Delegation**: Expose properties from injected controllers through main controller
- **Method Delegation**: Delegate method calls to appropriate injected controllers
- **State Coordination**: Main controller coordinates state between different dependencies

### GetView Usage Principles
- **Single Controller Binding**: GetView should bind to one main controller
- **Avoid Multiple Get.find()**: Never use multiple Get.find() calls in UI components
- **Access Through Main**: All controller interactions should go through the main controller
- **Simplified Testing**: Constructor DI makes controllers easily testable with mocks

## ✅ **Development Best Practices**

### Code Quality Standards
- **Constructor DI**: Use constructor-based dependency injection for better testability
- **Loading State Enums**: Use enum-based loading states instead of boolean flags
- **Const Constructors**: Use const constructors for performance optimization
- **Resource Disposal**: Properly dispose of resources in onClose methods
- **Specific Reactive Updates**: Use targeted Obx widgets instead of wrapping entire screens
- **Input Validation**: Validate all user inputs to prevent security vulnerabilities
- **Event Logging**: Log important application events for debugging and monitoring

### Anti-Patterns to Avoid
- **Service Locator in Business Logic**: Don't use Get.find() within controllers
- **Excessive Reactive Wrappers**: Don't wrap entire widgets in Obx unnecessarily
- **Ignored Error States**: Always handle error conditions in user flows  
- **Resource Leaks**: Don't forget to dispose of controllers and subscriptions
- **Business Logic in UI**: Keep business logic separate from presentation layer
- **God Controllers**: Avoid creating overly complex controllers with too many responsibilities

### Performance Optimization Rules
- **Const Widget Usage**: Use const constructors wherever possible to reduce rebuilds
- **Targeted Reactivity**: Apply reactive updates only to specific widgets that need updates
- **Proper Resource Management**: Dispose of unused resources to prevent memory leaks
- **Efficient State Updates**: Batch state updates when possible to reduce UI rebuilds
- **Image Optimization**: Implement proper caching for images and assets

### Security Considerations
- **Input Sanitization**: Validate and sanitize all user inputs
- **Secure Storage**: Use encrypted storage for sensitive data
- **Authentication Management**: Implement proper token refresh and logout mechanisms
- **Network Security**: Use HTTPS and validate SSL certificates
- **Data Encryption**: Encrypt sensitive data both in transit and at rest

## 📋 **Dependencies & Package Management Principles**

### Package Selection Guidelines
- **Community Trust**: Choose packages with active maintenance and large user base
- **Version Stability**: Prefer stable versions over bleeding-edge releases
- **Minimal Dependencies**: Select packages with minimal transitive dependencies
- **License Compatibility**: Ensure all dependencies have compatible licenses
- **Security Audit**: Regular security auditing of third-party packages

### Dependency Management Rules
- **Version Pinning**: Pin exact versions in production builds
- **Constraint Strategy**: Use caret (^) constraints for minor updates only
- **Regular Updates**: Schedule regular dependency update cycles
- **Breaking Change Testing**: Test thoroughly when updating major versions
- **Dependency Injection**: Abstract external packages behind interfaces

### Essential Package Categories
- **State Management**: GetX, Provider, Bloc (choose one consistently)
- **Network Layer**: Dio for HTTP, WebSocket channels for real-time
- **Storage**: Hive/Isar for local database, SharedPreferences for simple data
- **Utilities**: Logger, Connectivity, Device Info, Permission Handler
- **Testing**: Mockito, Flutter Test, Integration Test framework

## 🔄 **Data Synchronization & Conflict Resolution**

### Synchronization Strategies
- **Timestamp-Based Sync**: Use server timestamps to determine data freshness
- **Version-Based Conflict Resolution**: Implement version numbers for conflict detection
- **Last-Writer-Wins**: Simple conflict resolution for non-critical data
- **Merge Strategies**: Implement field-level merging for complex data structures
- **Sync Queue Management**: Queue operations for execution when connectivity returns

### Conflict Resolution Principles
- **Detect Before Merge**: Always detect conflicts before attempting data merge
- **User Choice**: Allow users to resolve conflicts when automatic resolution isn't possible
- **Backup Original**: Always backup original data before applying sync changes
- **Atomic Operations**: Ensure sync operations are atomic to prevent partial updates
- **Rollback Capability**: Implement rollback mechanism for failed sync operations

### Data Consistency Rules
- **Eventual Consistency**: Design for eventual consistency rather than immediate consistency
- **Optimistic Updates**: Apply local changes immediately, sync in background
- **Pessimistic Locking**: Use server-side locking for critical operations
- **Change Tracking**: Track all local changes for proper synchronization
- **Sync Status Indication**: Clearly indicate sync status to users

## ⚡ **Background Processing & Task Management**

### Background Task Principles
- **Battery Optimization**: Minimize background CPU usage and wake locks
- **Intelligent Scheduling**: Schedule tasks during optimal device conditions
- **Progressive Download**: Implement chunked downloads for large content
- **Retry Logic**: Implement exponential backoff for failed background tasks
- **Task Prioritization**: Prioritize critical tasks over nice-to-have operations

### Task Queue Management
- **FIFO with Priority**: First-in-first-out with priority override capability
- **Task Dependencies**: Handle task dependencies and execution order
- **Parallel Processing**: Execute independent tasks concurrently
- **Resource Management**: Limit concurrent tasks based on device capabilities
- **Progress Tracking**: Provide progress feedback for long-running tasks

### Memory Management
- **Resource Cleanup**: Properly dispose of resources after task completion
- **Memory Monitoring**: Monitor memory usage during background operations
- **Cache Management**: Implement intelligent cache eviction during background tasks
- **Garbage Collection**: Trigger GC after memory-intensive operations
- **Leak Prevention**: Prevent memory leaks in long-running background services

## 🔐 **Advanced Security Concepts**

### Certificate & Network Security
- **Certificate Pinning**: Pin certificates for critical API endpoints
- **SSL/TLS Validation**: Always validate SSL certificates and versions
- **Network Interception Prevention**: Detect and prevent network interception attempts
- **API Key Security**: Never hardcode API keys, use secure key management
- **Request Signing**: Implement request signing for sensitive operations

### Authentication & Authorization
- **Biometric Integration**: Support fingerprint, face, and voice authentication where available
- **Multi-Factor Authentication**: Implement MFA for sensitive operations
- **Session Management**: Proper session timeout and renewal mechanisms
- **Role-Based Access**: Implement fine-grained permission systems
- **Secure Token Storage**: Use platform keychain for sensitive tokens

### Data Protection
- **Data Anonymization**: Implement data anonymization for analytics and logging
- **PII Handling**: Special handling for personally identifiable information
- **Encryption at Rest**: Encrypt sensitive local data using platform security
- **Secure Communication**: End-to-end encryption for sensitive data transmission
- **Data Retention**: Implement proper data retention and deletion policies

## 🌐 **Internationalization (i18n) & Localization**

### Multi-Language Support Strategy
- **Locale Detection**: Automatically detect user's preferred language and region
- **Fallback Language**: Always provide fallback to default language when translations missing
- **Dynamic Language Switching**: Allow users to change language without app restart
- **Context-Aware Translation**: Consider context when translating (formal vs informal, gender, etc.)
- **Pluralization Rules**: Implement proper pluralization for different languages

### RTL (Right-to-Left) Language Support
- **Layout Direction**: Automatically adjust layout direction for RTL languages
- **Text Alignment**: Proper text alignment for different reading directions
- **Icon Mirroring**: Mirror directional icons appropriately for RTL languages
- **Navigation Flow**: Adjust navigation patterns for RTL reading patterns
- **Input Methods**: Support various input methods and keyboard layouts

### Cultural Considerations
- **Date/Time Formatting**: Use locale-appropriate date and time formats
- **Number Formatting**: Format numbers, currencies according to local conventions
- **Cultural Colors**: Be aware of cultural color meanings and taboos
- **Image Localization**: Consider cultural appropriateness of images and icons
- **Content Direction**: Adapt content flow to cultural reading patterns

## 📊 **Analytics & Monitoring Guidelines**

### User Behavior Tracking
- **Privacy-First Approach**: Always prioritize user privacy in analytics collection
- **Consent Management**: Implement proper consent mechanisms for data collection
- **Anonymous Analytics**: Collect analytics data without personally identifiable information
- **Event Categorization**: Organize events into logical categories (user actions, system events, errors)
- **Custom Dimensions**: Track relevant business metrics through custom dimensions

### Performance Metrics Collection
- **App Performance**: Monitor app startup time, frame rates, memory usage
- **Network Performance**: Track API response times, failure rates, retry counts
- **User Experience**: Measure user engagement, session duration, feature usage
- **Error Tracking**: Comprehensive error logging with stack traces and context
- **Business Metrics**: Track conversion rates, feature adoption, user retention

### Monitoring Strategy
- **Real-Time Monitoring**: Implement real-time monitoring for critical system health
- **Alerting System**: Set up alerts for performance degradation and errors
- **Dashboard Creation**: Create comprehensive dashboards for different stakeholders
- **Trend Analysis**: Analyze long-term trends to identify patterns and issues
- **Actionable Insights**: Ensure all collected data translates to actionable insights

## ♿ **Accessibility Standards**

### Universal Design Principles
- **Screen Reader Compatibility**: Ensure all UI elements are readable by screen readers
- **Semantic Labels**: Provide meaningful labels and descriptions for UI components
- **Focus Management**: Implement logical focus order for keyboard and assistive navigation
- **Touch Target Size**: Ensure touch targets meet minimum size requirements (44x44 pt)
- **Color Contrast**: Maintain sufficient color contrast ratios for text and backgrounds

### Input Method Support
- **Keyboard Navigation**: Support full keyboard navigation for all app functions
- **Voice Control**: Implement voice command support where applicable
- **Switch Control**: Support external switch devices for users with motor impairments
- **Alternative Input**: Support various alternative input methods and assistive devices
- **Gesture Alternatives**: Provide alternative methods for complex gestures

### Visual & Audio Accessibility
- **Dynamic Text Sizing**: Support system text size preferences and dynamic type
- **High Contrast Mode**: Adapt UI for high contrast accessibility mode
- **Reduced Motion**: Respect reduced motion preferences for animations
- **Audio Descriptions**: Provide audio descriptions for visual content where needed
- **Visual Indicators**: Ensure visual feedback doesn't rely solely on color

## 🚀 **CI/CD & DevOps Principles**

### Automated Testing Strategy
- **Test Pyramid**: Implement proper balance of unit, integration, and E2E tests
- **Continuous Testing**: Run tests automatically on every code change
- **Test Environment**: Maintain separate test environments that mirror production
- **Test Data Management**: Use consistent, realistic test data across environments
- **Performance Testing**: Include performance tests in CI/CD pipeline

### Build Pipeline Configuration
- **Multi-Environment Builds**: Configure builds for dev, staging, and production environments
- **Code Quality Gates**: Implement automated code quality checks and standards
- **Security Scanning**: Include automated security vulnerability scanning
- **Dependency Auditing**: Regular auditing of dependencies for security issues
- **Build Optimization**: Optimize build times through caching and parallelization

### Deployment Automation
- **Blue-Green Deployment**: Implement zero-downtime deployment strategies
- **Rollback Mechanism**: Automated rollback capability for failed deployments
- **Staged Rollout**: Gradual rollout to percentage of users for risk mitigation
- **Environment Parity**: Ensure development, staging, and production parity
- **Monitoring Integration**: Integrate deployment with monitoring and alerting systems

## 💾 **Advanced Caching Strategies**

### Multi-Level Caching Architecture
- **Memory Cache**: Fast in-memory caching for frequently accessed data
- **Disk Cache**: Persistent disk caching for larger datasets and offline support
- **Network Cache**: HTTP caching with proper cache headers and ETags
- **Database Cache**: Query result caching for expensive database operations
- **CDN Integration**: Leverage CDN for static asset caching and distribution

### Cache Management Principles
- **Cache Invalidation**: Implement intelligent cache invalidation strategies
- **TTL (Time To Live)**: Set appropriate TTL values based on data volatility
- **LRU Eviction**: Use Least Recently Used eviction for memory-constrained environments
- **Cache Warming**: Pre-populate caches with frequently accessed data
- **Cache Coherence**: Ensure cache consistency across multiple data sources

### Performance Optimization
- **Prefetching Logic**: Implement predictive prefetching based on user behavior
- **Lazy Loading**: Load data only when needed to optimize initial app performance
- **Image Caching**: Efficient image caching with proper compression and sizing
- **API Response Caching**: Cache API responses with appropriate invalidation rules
- **Background Sync**: Update caches in background to maintain fresh data

## 🔧 **Configuration Management**

### Environment-Specific Configurations
- **Environment Variables**: Use environment variables for configuration values
- **Build-Time Configuration**: Configure values at build time for different environments
- **Runtime Configuration**: Support runtime configuration changes where appropriate
- **Secrets Management**: Secure management of API keys, certificates, and secrets
- **Configuration Validation**: Validate configuration values at startup

### Feature Flag Implementation
- **Progressive Rollout**: Use feature flags for gradual feature rollouts
- **A/B Testing**: Implement A/B testing framework through feature flags
- **Kill Switches**: Emergency kill switches for problematic features
- **User Segmentation**: Target specific user segments with different features
- **Flag Lifecycle**: Proper lifecycle management for feature flags

### Remote Configuration
- **Dynamic Updates**: Support dynamic configuration updates without app updates
- **Configuration Caching**: Cache configuration locally for offline scenarios
- **Fallback Values**: Always provide sensible fallback values for configurations
- **Configuration Versioning**: Version control for configuration changes
- **Real-Time Updates**: Real-time configuration updates for critical changes

## 🧪 **Testing & Quality Assurance Principles**

### Unit Testing Requirements
- **Mock Dependencies**: All external dependencies must be mockable
- **Business Logic Coverage**: 100% coverage for business logic (use cases)
- **State Testing**: Test all possible state transitions in controllers
- **Error Scenarios**: Test error handling and edge cases
- **Isolation Testing**: Each component should be testable in isolation

### Integration Testing Strategy
- **End-to-End Flows**: Test complete user journeys
- **API Integration**: Test actual API communication with test servers
- **Storage Integration**: Test local storage operations
- **Network Scenarios**: Test various network conditions (offline, slow, intermittent)

### Performance Testing Criteria
- **Memory Usage**: Monitor memory consumption and detect leaks
- **CPU Utilization**: Ensure efficient CPU usage during content display
- **Battery Impact**: Minimize battery drain on mobile devices
- **Loading Performance**: Measure and optimize content loading times

### Deployment Considerations
- **Environment Management**: Separate configurations for dev, staging, production
- **Build Optimization**: Different build configurations for different deployment targets
- **Release Strategy**: Staged rollout with ability to halt deployment if issues arise
- **Monitoring Integration**: Implement crash reporting and performance monitoring

## 🎉 **Core Development Principles Summary**

### Architectural Fundamentals
- **Clean Architecture**: Maintain strict layer separation for maintainable code
- **Constructor DI**: Use dependency injection for better testability and flexibility
- **Single Responsibility**: Each class should have one reason to change
- **Reactive Programming**: Use reactive patterns for responsive UI updates

### Cross-Platform Considerations
- **Platform-Adaptive Design**: Design UI that adapts appropriately to different platforms
- **Input Method Flexibility**: Support various input methods (touch, keyboard, remote, voice)
- **Performance Optimization**: Optimize for different hardware capabilities and screen sizes
- **Accessibility**: Ensure consistent accessibility across all supported platforms

### Quality Standards
- **Error Resilience**: Gracefully handle all error conditions
- **Performance First**: Optimize for smooth user experience across all devices
- **Security Conscious**: Implement proper authentication and data protection
- **Testing Coverage**: Comprehensive testing at all architectural layers

### Development Guidelines
- **Code Consistency**: Follow established patterns throughout the codebase
- **Documentation**: Document all business logic and architectural decisions
- **Monitoring**: Implement comprehensive logging and error tracking
- **Maintainability**: Write code that can be easily understood and modified by team members
- **Scalability**: Design systems that can scale with growing user base and feature requirements
